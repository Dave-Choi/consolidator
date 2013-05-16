class UsersController < ApplicationController
    before_filter :authenticate_user!

    respond_to :json, :html

    # GET /users/
    def index
        @users = User.all
        respond_with @users
    end

    # GET /users/1
    # GET /users/1.json
    def show
        id = params[:id]
        if current_user.id == params[:id].to_i 
            @user = current_user
        else
            @user = current_user.friends.find(id)
        end

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @user }
        end
    end

    # GET /users/current
    def current
        @user = current_user
        respond_with @user
    end
end
