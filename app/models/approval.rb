=begin
    Approvals represent per-owner responses to requests to borrow
    Things.

    Status should be one of "accepted", "rejected", or "pending" (default).
=end

class Approval < ActiveRecord::Base
  belongs_to :borrow_request
  belongs_to :user
  attr_accessible :status
end
