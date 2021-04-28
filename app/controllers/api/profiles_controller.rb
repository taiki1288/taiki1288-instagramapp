class Api::ProfilesController < Api::ApplicationController
    before_action :authenticate_user!

    def show
      @profile = current_user.profile
      render json: @profile
    end

    def edit
      @profile = current_user.prepare_profile
    end

    def update
    #   binding.pry
      @profile = current_user.prepare_profile
      @profile.assign_attributes(profile_params)
      render json: @profile
    end

    private
    def profile_params
      params.require(:profile).permit(:avatar)
    end
end