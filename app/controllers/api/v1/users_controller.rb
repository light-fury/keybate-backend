class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:index, :show, :update]
  before_filter :set_user, only: [:show, :update]
  respond_to :json

  def index
    if params[:id]
      @users = User.where(id: params[:id].split(','))
    elsif params[:api_user_id]
      @users = User.where(api_user_id: params[:api_user_id])
    end

    render json: @users
  end

  def show
    render json: @user, serializer: UserSerializer
  end

  def create
    # New user will be created if no other user with the same api_user_id exists.
    # Else, the existing user will be saved with no updates (change in the future for performance).
    @existing = User.find_by(api_user_id: user_params[:api_user_id])

    if @existing.present?
      @user = @existing
    else
      @user = User.new(user_params)
    end

    if @user.save
      render json: @user, status: :created, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :accepted, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def password_reset
      reset_code = params[:reset_code]
      reset_password_token = Devise.token_generator.digest(self, :reset_password_token, reset_code)
      user = User.find_by(reset_password_token: reset_password_token)
      
      if user == nil
        return render :json => { :success => false, :notice => 'Unable to find user' }
      end

      if user.reset_password_sent_at < 1.hour.ago
        return render :json => { :success => false, :notice => 'Password Token has now expired' }
      elsif user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
        return render :json => { :success => true, :notice => 'Password has been updated' }
      else
        return render :json => { :success => false, :notice => 'Unknown error has occured' }
      end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :location, :description, :position, :picture_url, :api_user_id, :facebook_profile_link, :linkedin_profile_link, :deleted)
    end
end
