class FriendshipsController < ApplicationController
    before_filter :authenticate_user!

    # GET /friends
    # GET /friends.json
    def index
        @incoming_requests = current_user.pending_invited_by
        @outgoing_requests = current_user.pending_invited
        @friends = current_user.friends
    end

    def new
        # Show everyone where it's not a mutual friendship, 
        # as you might have forgotten that you sent a request already, 
        # and having the target user not present in the list could be confusing.
        @available_friends = current_user.not_friends 
    end

    def create
        friend = User.find_by_id(params[:id])
        if current_user.invite friend
            redirect_to new_friend_path, :notice => "A friend request has been sent to #{friend.name}"
        else
            redirect_to new_friend_path, :notice => "There was a problem sending a friend request to #{friend.name}"
        end
    end


    def update
        # Confirm incoming friend request
        friend = User.find_by_id(params[:id])
        if current_user.approve friend
          redirect_to friends_path, :notice => "Confirmed #{friend.name} as friend."
        else
          redirect_to friends_path, :notice => "There was a problem confirming #{friend.name}'s friend request."
        end
    end

    def destroy
        user = User.find_by_id(params[:id])
        if current_user.remove_friendship user
            redirect_to friends_path, :notice => "Removed #{user.name} from friends"
        else
            redirect_to friends_path, :notice => "There was a problem removing #{user.name} from friends"
        end
    end

end
