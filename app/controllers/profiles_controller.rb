class ProfilesController < ApplicationController
    before_action :authenticate_user!
    def show
      @profile = current_user.profile
    end

    def edit
      @profile = current_user.prepare_profile
    end

    def update
      @profile = current_user.prepare_profile
      @profile.assign_attributes(profile_params)
      respond_to do |format|
        if @profile.save!
          format.html { redirect_to @profile }
          format.json { render json: @profile }
        end
      end
    end

    private
    def profile_params
      params.require(:profile).permit(:avatar)
    end
end