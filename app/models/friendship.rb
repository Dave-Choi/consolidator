=begin
    Friendships define relationships between Users, which will
    enable Users to define networks of people with which they're
    comfortable sharing their stuff with.

    Trusted users would then be able to see a catalog of things
    you're willing to lend, for example.
=end

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"
end
