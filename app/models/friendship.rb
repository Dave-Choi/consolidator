=begin
    Friendships define relationships between Users, which will
    enable Users to define networks of people with which they're
    comfortable sharing their stuff with.

    Trusted users would then be able to see a catalog of things
    you're willing to lend, for example.

    Friendships are directed relationships, meaning that there's
    a source user (user_id in the schema), and a target user 
    (friend_id in the schema).

    Sharing should be enabled when a friendship is bidirectional,
    but User records can be initialized when a User claims someone
    has their stuff and initiates the friendship.
=end

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"
end
