class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :recoverable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  has_many :things, :through => :transfers
  has_many :transfers

  has_many :things, :through => :stakes
  has_many :stakes

  include Amistad::FriendModel

  def not_friends()
    # returns the set of Users that aren't accepted (on either end) friends, or self
    return User.where("id not in (?)", self.friends.pluck(:id).push(self.id))
  end

  def pending_invited_by?(user)
    # checks if a current user has a pending invitation from given user
    friendship = find_any_friendship_with(user)
    return false if friendship.nil?
    return friendship.friendable_id == user.id && friendship.pending == true
  end

  def pending_invited?(user)
    # checks if a current user invited given user, pending response
    friendship = find_any_friendship_with(user)
    return false if friendship.nil?
    return friendship.friend_id == user.id && friendship.pending == true
  end
end
