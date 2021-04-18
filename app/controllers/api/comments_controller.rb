class Api::CommentsController < Api::ApplicationController
    def index
        timeline = Timeline.find(params[:timeline_id])
        comments = timeline.comments
        render json: comments, include: { user: [:profile] }
    end

    def create
        timeline = Timeline.find(params[:timeline_id])
        @comment = timeline.comments.build(comment_params)
        @comment.save!
        render json: @comment, include: { user: [:profile] }
    end

    def destroy
        timeline = Timeline.find(params[:timeline_id])
        @comment = current_user.timeline.comments.find(params[:id])
        @comment.destroy!
        # render json: @comment, include: { user: [:profile] }
    end

    private
    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end
end