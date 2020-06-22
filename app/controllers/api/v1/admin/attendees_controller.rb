class Api::V1::Admin::AttendeesController < ApplicationController
  before_action :authenticate_api_v1_user!
  respond_to :json

  def index
    rooms = Room.find_by!(id: params[:room_id], event_id: params[:event_id])
    authorize rooms.event_user_rooms.first if rooms.event_user_rooms.first
    @users = rooms.users
  end
end
