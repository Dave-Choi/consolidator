class Thing < ActiveRecord::Base
  attr_accessible :name

  has_many :stakes
  has_many :users, :through => :stakes

  has_many :transfers
  has_many :giver, :through => :transfers # Is this the right way to do this?
  has_many :receiver, :through => :transfers # Is this the right way to do this?
end
