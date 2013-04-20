=begin
    A Thing is any owned thing that may transfer between Users.

    The system maintains information about its transfer history, and
    ownership, which may be between multiple people.
=end

class Thing < ActiveRecord::Base
  attr_accessible :name

  # This may not be the best way to handle this.  
  # With an index on transfer datetimes, it's probably enough to just have
  # an "added_by" key, and then just track the holder via the most recent transfer
  belongs_to :holder, :class_name => "User", :foreign_key => "held_by"

  has_many :stakes
  has_many :users, :through => :stakes

  has_many :transfers
  has_many :givers, :through => :transfers
  has_many :receivers, :through => :transfers


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

  # TODO: This stuff should probably be converted to Arel scopes.
  def self.borrowed(user)
    # Borrowed Things are defined as things in the user's possession
    # where the user has no stakes

    staked = Stake.where("user_id = #{user.id}").pluck("thing_id")
    return Thing.where("held_by = #{user.id} and things.id not in (?)", staked)
  end

  def self.available(user)
    # Things that user has friends with stakes in.
    # TODO: This set includes things that the user has stakes in
    #       This might be almost okay.  Have to think about how users will want to use the system.
    #       i.e. The "available" view is used when the user needs/wants a thing.  If they already own one,
    #           that information is useful.
    #           It should probably give the full list, and a filter to exclude owned things should be provided on the front-end.
    return Thing.where("held_by != #{user.id} and id in (?)", Stake.where("user_id in (?)", user.friends.pluck('id') ).pluck("thing_id") )
  end

  def self.viewable(user)
    # Things that are owned by the user or friends of the user
    return Thing.where("id in (?)", Stake.where("user_id in (?)", user.friends.pluck('id').push(user.id) ).pluck("thing_id") )
  end

  def owned_by_friend?(user)
    # Returns true if this Thing is owned by a friend of user.
    owner_ids = self.users.pluck("users.id")
    friend_ids = user.friends.pluck("id")
    return !(owner_ids & friend_ids).empty?
  end
end
