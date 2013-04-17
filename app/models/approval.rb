class Approval < ActiveRecord::Base
  belongs_to :borrow_request
  belongs_to :user
  attr_accessible :status
end
