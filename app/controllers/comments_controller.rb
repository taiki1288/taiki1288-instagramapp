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

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end