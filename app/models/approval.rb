=begin
    Approvals represent per-owner responses to requests to borrow
    Things.

    Status should be one of "accepted", "rejected", or "pending" (default).

    TODO: The record's timestamps should be updated whenever the status is updated
=end

class Approval < ActiveRecord::Base
  belongs_to :borrow_request
  belongs_to :user
  attr_accessible :status, :inclusion => { :in => %w(approved rejected pending),
    :message => "%{value} is not a valid size" }
end
