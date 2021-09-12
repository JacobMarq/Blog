class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def follow
        @user = User.find(params[:id])
        Friendship.create(follower_id: current_user.id, follows_id: @user.id)
    end

    def unfollow
        @user = User.find(params[:id])
        @friendship = @user.select_friendship(current_user)
        @friendship.destroy
    end
end