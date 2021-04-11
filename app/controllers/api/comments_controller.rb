class Api::CommentsController < Api::ApplicationController
    def index
        timeline = Timeline.find(params[:timeline_id])
        comments = timeline.comments
        render json: comments
    end

    def create
        timeline = Timeline.find(params[:timeline_id])
        @comment = timeline.comments.build(comment_params)
        @comment.save!
        render json: @comment
    end

    private
    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end
end