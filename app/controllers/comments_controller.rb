class CommentsController < ApplicationController
    def index
        @timeline = Timeline.find(params[:timeline_id])
        comments = @timeline.comments
    end

    def create
        timeline = Timeline.find(params[:timeline_id])
        @comment = timeline.comments.build(comment_params)
        @comment.save!
    end

    def destroy
        timeline = Timeline.find(params[:timeline_id])
        comment = current_user.timeline.comments.find(params[:id])
        comment.destroy!
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end