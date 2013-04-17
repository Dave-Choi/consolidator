class BorrowRequest < ActiveRecord::Base
  belongs_to :thing
  belongs_to :user
  # attr_accessible :title, :body
end
