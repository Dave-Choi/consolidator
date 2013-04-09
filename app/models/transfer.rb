class Transfer < ActiveRecord::Base
  attr_accessible :datetime

  belongs_to :giver, :class_name => "User", :foreign_key => "from_user_id"
  validates :from_user_id, presence: true

  belongs_to :receiver, :class_name => "User", :foreign_key => "to_user_id"
  validates :to_user_id, presence: true

  belongs_to :thing
  validates :thing_id, presence: true
end
