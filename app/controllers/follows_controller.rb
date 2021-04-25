class FollowsController < ApplicationController
    before_action :authenticate_user!

    def show
        user = User.find(params[:account_id])
        follow_status = current_user.has_followed?(user)
        follower_count = user.follower_counts(user)
        following_count = user.following_counts(user)
        render json: { hasFollowed: follow_status, followerCounts: follower_count, followingCounts: following_count }
    end

    def create
        user = User.find(params[:account_id])
        current_user.follow!(user)
        follower_count = user.follower_counts(user)
        following_count = user.following_counts(user)
        render json: { status: 'ok', followerCounts: follower_count, followingCounts: following_count }
    end
end