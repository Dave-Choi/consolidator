=begin
    When a User wants to borrow a Thing, a BorrowRequest is
    created, which represents the intent to borrow the item.

    When the request is created, it should spawn Approval records
    to ping each owner for their OK to borrow the item.
        - If any Approval is rejected, the BorrowRequest fails.
        - If all Approvals are accepted, the BorrowRequest succeeds,
        and a transfer should be initiated.
        - The borrower and holder should be presented with a confirmation
        prompt to notify the system that the transfer has taken place
            - At which point a Transfer record is created, and the request is resolved
=end

class BorrowRequest < ActiveRecord::Base
  belongs_to :thing
  belongs_to :user

  has_many :approvals, :dependent => :destroy
  has_one :transfer

  def status()
    # Returns the overall status of the BorrowRequest, depending on the
    # statuses of its associated Approvals and Transfers

    # Request status is as follows:
    # "rejected" if any of the Approvals are rejected,
    # "pending" if not rejected, and any of the Approvals are pending (this means pending approval),
    # "transferred" if not pending approval or rejected, and a transfer record exists for this request
    # "approved" otherwise -- This is notably mutually exclusive from transferred.

    statuses = self.approvals.pluck('status')

    if(statuses.include?('rejected'))
        return 'rejected'
    elsif (statuses.include?('pending'))
        return 'pending'
    else
        if(self.transfer)
            return 'transferred'
        else
            return 'approved'
        end
    end
  end

  # The following scopes reflect the definitions from the status() method.
  # These are wrapped in lambdas to avoid cached results.

  # This is necessary because when ids is empty, the SQL becomes 'where id not in (NULL)', which will always return an empty set.
  scope :excluding_ids, lambda { |ids| where(['id not in (?)', ids]) if ids.any? }

  scope :rejected, lambda{ joins(:approvals).where("approvals.status = 'rejected'") }
  scope :pending, lambda{ excluding_ids(rejected).joins(:approvals).uniq.where("approvals.status = 'pending'") }
  # TODO: This is an alternate way to do the query using squeel, which might be faster.  Run a test.
  # scope :pending, lambda{ where{id.not_in my{rejected}}.joins(:approvals).uniq.where("approvals.status = 'pending'") }
  scope :transferred, lambda{ joins(:transfer) }
  scope :approved, lambda{ excluding_ids(rejected | pending | transferred) }

  # actionable requests are ones that are not resolved by being transferred.
  #   Rejected requests are included to be dismissable by the requester
  scope :actionable, lambda{ where("borrow_requests.id not in (?)", transferred) }

  def create_approvals()
    # Creates one approval for each User with a stake in the Thing
    # to be borrowed
    owners = self.thing.users
    was_successful = true
    owners.each do |owner|
        new_approval = Approval.new()
        new_approval.borrow_request = self
        new_approval.user = owner
        was_successful = new_approval.save! && was_successful
    end
    return was_successful
  end

  def self.most_recent_actionable(thing, user)
    # A request is considered actionable if it's not transferred.
    # This includes requests that have been rejected, so the requester must
    # acknowledge and dismiss a rejected request before making a new one for
    # the same thing.

    # Order requests in descending chronological order as newer requests should be more likely to have actionable status.

    return user.borrow_requests.actionable.where(:thing_id => thing.id).order('created_at desc').first
  end

  def self.request_actionable?(thing, user)
    return BorrowRequest.most_recent_actionable(thing, user) != nil
  end

  def self.request_valid?(thing, user)
    # TODO: This function needs unit testing like nobody's business.
    #       It also does too much stuff, and should be broken down and
    #       reorganized so it only checks as much as it needs to, and
    #       can give useful status messages if someone tries to make a bad request

    # A request shouldn't be made if:
    #   - the user has a stake in the item
    #   - the user already has the Thing
    #   - the thing isn't available in the User's network
    #   - an actionable request already exists

    user_is_owner = Stake.where("user_id = #{user.id} and thing_id = #{thing.id}").exists?
    user_has_thing = thing.held_by == user.id
    actionable_request_exists = BorrowRequest.request_actionable?(thing, user)

    return !(
        user_is_owner ||
        user_has_thing ||
        !thing.owned_by_friend?(user) ||
        actionable_request_exists
    )
  end

  def self.init_request(thing, user)
    # Sets up a transaction to create a new BorrowRequest and associated
    # Approvals.
    if !BorrowRequest.request_valid?(thing, user)
        return false
    end

    was_successful = false

    ActiveRecord::Base.transaction do
        new_request = BorrowRequest.new
        new_request.thing = thing
        new_request.user = user
        was_successful = new_request.save!

        was_successful = new_request.create_approvals() && was_successful
    end

    return was_successful
  end

  def build_transfer()
    new_transfer = Transfer.new
    new_transfer.borrow_request = self
    new_transfer.receiver = self.user
    new_transfer.thing = self.thing
    new_transfer.giver = self.thing.holder
    new_transfer.datetime = DateTime.current

    return new_transfer
  end

end
