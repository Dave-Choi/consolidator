=begin
    A Thing is any owned thing that may transfer between Users.

    The system maintains information about its transfer history, and
    ownership, which may be between multiple people.
=end

class Thing < ActiveRecord::Base
  attr_accessible :name

  has_many :stakes
  has_many :users, :through => :stakes

  has_many :transfers
  has_many :giver, :through => :transfers # Is this the right way to do this?
  has_many :receiver, :through => :transfers # Is this the right way to do this?
end
