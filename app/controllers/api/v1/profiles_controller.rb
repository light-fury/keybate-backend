class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_user, only: [:show, :update]
  respond_to :json

  def show
  end

  def update
    @user.update!(user_params)
  end

  private

  def user_params
    params.permit(:password, :first_name, :last_name, :location, :position, :picture_url, :facebook_profile_link, :linkedin_profile_link, :description, :deleted)
  end

  def set_user
    @user = current_api_v1_user
  end
end
