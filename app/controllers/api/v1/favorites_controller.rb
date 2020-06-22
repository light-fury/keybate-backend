class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_filter :set_favorite, only: [:show, :destroy]
  respond_to :json

  def index
    if params[:user_id] && params[:following_id]
      @favorites = Favorite.where(user_id: params[:user_id], following_id: params[:following_id])
    elsif params[:user_id]
      @favorites = Favorite.where(user_id: params[:user_id].split(','))
    elsif params[:following_id]
      @favorites = Favorite.where(following_id: params[:following_id])
    elsif params[:id]
      @favorites = Favorite.where(id: params[:id])
    end

    render json: @favorites
  end

  def show
    render json: @favorite, serializer: FavoriteSerializer
  end

  def create
    @favorite = Favorite.new(favorite_params)

    if @favorite.save
      render json: @favorite, status: :created, location: [:api, @favorite]
    else
      render json: { errors: @favorite.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite.destroy
    head :no_content
  end

  private

    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    def favorite_params
      params.require(:favorite).permit(:user_id, :following_id, :met_in_room,
                                       :room_id, :room_name)
    end

end
