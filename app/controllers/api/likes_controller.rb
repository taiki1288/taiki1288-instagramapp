class Api::LikesController < Api::ApplicationController
    before_action :authenticate_user!

    def show
        timeline = Timeline.find(params[:timeline_id])
        like_status = current_user.has_liked?(timeline)
        render json: { hasLiked: like_status }
    end

    def create
        timeline = Timeline.find(params[:timeline_id])
        timeline.likes.create!(user_id: current_user.id)
        
        render json: { status: 'ok' }
    end

    def destroy
        timeline = Timeline.find(params[:timeline_id])
        like = timeline.likes.find_by!(user_id: current_user.id)
        like.destroy!

        render json: { status: 'ok' }
    end
end