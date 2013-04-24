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


    TODO: A borrow request should be considered unresolved unless it was
        rejected, or it's approved and a transfer took place, or the request was cancelled
        (in which case the record and its approvals are destroyed).
=end

class BorrowRequest < ActiveRecord::Base
  belongs_to :thing
  belongs_to :user

  has_many :approvals, :dependent => :destroy
  has_one :transfer

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

  def self.request_pending?(thing, user)
    # A request is only pending if none of its approvals are rejected,
    # or there's a pending transfer.  This notably excludes accepted requests
    # without a pending transfer.

    # Only check the most recent one, to save processing.

    # If this is being used properly, a new request shouldn't go through when there's
    # one that's still unresolved.

    # TODO: This can actually break if a user approves/rejects a request,
    #       and then undoes the action after a new request is made.
    most_recent_request = BorrowRequest.where("user_id = #{user.id} and thing_id = #{thing.id}").order("created_at desc").first
    pending_request_exists = most_recent_request ? 
        most_recent_request.status() == "pending" : 
        false
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
    #   - a pending request already exists

    user_is_owner = Stake.where("user_id = #{user.id} and thing_id = #{thing.id}").exists?
    user_has_thing = thing.held_by == user.id
    pending_request_exists = BorrowRequest.request_pending?(thing, user)

    return !(
        user_is_owner ||
        user_has_thing ||
        !thing.owned_by_friend?(user) ||
        pending_request_exists
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

  def status()
    # Returns the overall status of the BorrowRequest, depending on the
    # statuses of its associated Approvals

    # Request status is as follows:
    # "rejected" if any of the Approvals are rejected,
    # "pending" if not rejected, and any of the Approvals are pending (this means pending approval),
    # "transferred" if not pending approval or rejected, and a transfer record exists for this request
    # "approved" otherwise.

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
  scope :rejected, lambda{ joins(:approvals).where("approvals.status = 'rejected'") }
  scope :pending, lambda{ where("borrow_requests.id not in (?)", rejected).joins(:approvals).where("approvals.status = 'pending'") }
  scope :approved, lambda{ where("borrow_requests.id not in (?)", rejected | pending) }
end
