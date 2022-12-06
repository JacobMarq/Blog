class UsersController < ApplicationController
    def following
        @user = User.find(params[:id])
        @following = @user.follows
    end

    def followers
        @user = User.find(params[:id])
        @following = @user.followers
    end
    
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def follow
        @user = User.find(params[:id])
        Friendship.create(follower_id: current_user.id, follows_id: @user.id)
        redirect_back(fallback_location: @user)
    end

    def unfollow
        @user = User.find(params[:id])
        @friendship = @user.select_friendship(current_user)
        @friendship.destroy
        redirect_back(fallback_location: @user)
    end
end