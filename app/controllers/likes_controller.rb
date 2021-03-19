class LikesController < ApplicationController
    before_action :authenticate_user!

    def show
        timeline = Timeline.find(params[:timeline_id])
        like_status = current_user.has_liked?(timeline)
        render json: { hasLiked: like_status }
    end

    def create
        timeline = Timeline.find(params[:timeline_id])
        timeline.likes.create!(user_id: current_user.id)
        redirect_to root_path(timeline)
    end

    def destroy
        timeline = Timeline.find(params[:timeline_id])
        like = timeline.likes.find_by!(user_id: current_user.id)
        like.destroy!
        redirect_to root_path(timeline)
    end
end