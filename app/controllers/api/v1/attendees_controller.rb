class Api::V1::AttendeesController < ApplicationController
  before_action :authenticate_api_v1_user!
  respond_to :json

  def index
    if params[:event_id] && params[:room_id]
      room = Room.includes(:users).find_by!(id: params[:room_id], event_id: params[:event_id])
      authorize room.event_user_rooms.first if room.event_user_rooms.first
      @users = room.users
    else
      event = Event.includes(:users).find(params[:event_id])
      # authorize event.rooms.first.event_user_rooms.first if event.rooms.first.event_user_rooms.first
      @users = event.users
    end
  end
end
