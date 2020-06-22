class Api::V1::ModeratorsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_filter :set_moderator, only: [:show, :update]
  respond_to :json

  def index
    if params[:room_id] && params[:user_id]
      @moderators = Moderator.where(room_id: params[:room_id], user_id: params[:user_id])
    elsif params[:room_id]
      @moderators  = Moderator.where(room_id: params[:room_id])
    elsif params[:user_id]
      @moderators  = Moderator.where(user_id: params[:user_id])
    elsif params[:id]
      @moderators = Moderator.where(id: params[:id])
    end

    render json: @moderators
  end

  def show
    render json: @moderator, serializer: ModeratorSerializer
  end

  def create
    @moderator = Moderator.new(moderator_params)

    if @moderator.save
      render json: @moderator, status: :created, location: [:api, @moderator]
    else
      render json: { errors: @moderator.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @moderator.update(moderator_params)

      head :no_content
    else
      render json: { errors: @moderator.errors }, status: :unprocessable_entity
    end
  end

  private

    def set_moderator
      @moderator = Moderator.find(params[:id])
    end

    def moderator_params
      params.require(:moderator).permit(:room_id, :user_id)
    end
end
