=begin
    Approvals represent per-owner responses to requests to borrow
    Things.

    status defaults to "pending" at creation.
=end

class Approval < ActiveRecord::Base
  belongs_to :borrow_request
  belongs_to :user
  attr_accessible :status, :inclusion => { :in => %w(approved rejected pending),
    :message => "%{value} is not a valid status" }

  has_one :thing, :through => :borrow_request
  has_one :borrower, :through => :borrow_request, :source => :user
end
