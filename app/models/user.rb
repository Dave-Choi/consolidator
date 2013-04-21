class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :recoverable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body


  has_many :received_transfers, :class_name => "Transfer", :foreign_key => "to_user_id"
  has_many :received_things, :through => :received_transfers, :source => :thing

  has_many :given_transfers, :class_name => "Transfer", :foreign_key => "from_user_id"
  has_many :given_things, :through => :given_transfers, :source => :thing

  has_many :owned_things, :through => :stakes, :source => :thing
  has_many :stakes

  has_many :requested_things, :through => :borrow_requests, :source => :thing
  has_many :borrow_requests

  has_many :approvals

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
