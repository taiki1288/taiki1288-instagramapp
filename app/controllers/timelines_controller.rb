class TimelinesController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create, :edit, :destroy]

    def index
        @timelines = Timeline.all
        # user_ids = current_user.followings.pluck(:id)
        # @timelines = Timeline.where(user_id: user_ids)
    end

    def show
        @timeline = Timeline.find(params[:id])
    end

    def new
        @timeline = current_user.timelines.build
    end

    def create
        @timeline = current_user.timelines.build(timeline_params)
        if @timeline.save!
            redirect_to timelines_path(@timeline)
        else
            render :new
        end
    end

    def edit
       @timeline = current_user.timelines.find(params[:id]) 
    end

    def update
        @timeline = current_user.timelines.find(params[:id])
        if @timeline.update(timeline_params)
            redirect_to timelines_path(@timeline)
        else
            render :new
        end
    end

    def destroy
        timeline = current_user.timelines.find(params[:id])
        timeline.destroy!
        redirect_to root_path
    end

    private 
      def timeline_params
        params.require(:timeline).permit(:content, images: [])
      end
end
