=begin
    A Thing is any owned thing that may transfer between Users.

    The system maintains information about its transfer history, and
    ownership, which may be between multiple people.
=end

class Thing < ActiveRecord::Base
  attr_accessible :name

  belongs_to :holder, :class_name => "User", :foreign_key => "held_by"

  has_many :stakes
  has_many :users, :through => :stakes

  has_many :transfers
  has_many :giver, :through => :transfers # Is this the right way to do this?
  has_many :receiver, :through => :transfers # Is this the right way to do this?


# Would be too inefficient to run on every Thing all the time:
  # def held_by()
  #   # Returns the user the Thing was most recently transferred to.
  #   last_transfer = self.transfers.order("datetime desc").limit(1).first
  #   if(last_transfer)
  #       return last_transfer.receiver
  #   else
  #       return nil
  #   end
  # end



end
