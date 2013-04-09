=begin 
    Stakes represent the amount of ownership a User has of a Thing,
    analogous to stocks.

    That is, the User's percentage ownership is the total Stakes amount for the
    Thing, divided by the User's Stake amount.

    One of the eventual goals of the app is to facilitate resource pooling,
    for group purchases and this will result in multiple ownership, so
    it's important to have some way to model this.

    These percentages can be used in case someone wants to buy out the
    other owners' equity, or destroys the item and needs to reimburse the
    other owners, etc.

    amount is specified as a decimal value, which is simpler to use for
    doing straight currency conversion to Stakes.

    e.g. Mike, Juan and Jerry all want to play a new RPG that costs $60.
        They agree that Mike will get it first, then Juan, then Jerry, with
        the understanding that RPGs are long, and by the time Jerry gets it,
        it won't be new anymore, so they say Jerry can chip in $15,
        and Mike and Juan will both pay $22.50.

        Stake records can be created with the amounts: 22.5, 22.5, 15
        and the system will calculate 37.5% ownership for Mike and Juan,
        and 25% for Jerry.
=end

class Stake < ActiveRecord::Base
  attr_accessible :amount

  belongs_to :user
  belongs_to :thing
end
