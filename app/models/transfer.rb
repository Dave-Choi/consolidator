=begin
    Transfers are dated records of transfers of a thing between Users.
    
    If Users are diligent about recording transfers, presumably the
    receiver of the most recent transfer should be the person in
    possession of the Thing.
=end

end

class Transfer < ActiveRecord::Base
  attr_accessible :datetime

  belongs_to :giver, :class_name => "User", :foreign_key => "from_user_id"
  validates :from_user_id, presence: true

  belongs_to :receiver, :class_name => "User", :foreign_key => "to_user_id"
  validates :to_user_id, presence: true

  belongs_to :thing
  validates :thing_id, presence: true
end
