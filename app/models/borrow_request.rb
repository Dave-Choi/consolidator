=begin
    When a User wants to borrow a Thing, a BorrowRequest is
    created, which represents the intent to borrow the item.

    When the request is created, it should spawn Approval records
    to ping each owner for their OK to borrow the item.
        - If any Approval is rejected, the BorrowRequest fails.
        - If all Approvals are accepted, the BorrowRequest succeeds,
        and a transfer should be initiated.
=end

class BorrowRequest < ActiveRecord::Base
  belongs_to :thing
  belongs_to :user

  has_many :approvals, :dependent => :destroy

  def create_approvals()
    # Creates one approval for each User with a stake in the Thing
    # to be borrowed
    owners = self.thing.users
    owners.each do |owner|
        new_approval = Approval.new()
        new_approval.borrow_request = self
        new_approval.user = owner
        new_approval.save!
    end
  end
end
