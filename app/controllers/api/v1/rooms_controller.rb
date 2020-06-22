class Api::V1::RoomsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_room, only: [:show, :join]
  respond_to :json

  def index
    @rooms = current_event.rooms
    authorize @rooms.first
  end

  def show
    authorize @room
  end

  def join
    authorize @room
    unless current_api_v1_user.has_role? :room_attendee, @room
      event_user_room = @room.event_user_rooms.new(event_user_id: current_event_user.id)
      if event_user_room.save!
        current_api_v1_user.add_role :room_attendee, @room

        ActionCable.server.broadcast "attendees_#{current_event.id}",
          action: 'join_room',
          user_id: event_user_room.event_user.user_id,
          room_id: event_user_room.room_id,
          first_name: current_event_user.user.first_name,
          last_name: current_event_user.user.last_name,
          position: current_event_user.user.position,
          location: current_event_user.user.location,
          picture_url: current_event_user.user.picture_url
        head :ok
      end
    end
  end

  private

  def current_event
    Event.find(params[:event_id])
  end

  def current_event_user
    current_event.event_users.find_by(user_id: current_api_v1_user.id)
  end

  def set_room
    @room = current_event.rooms.find(params[:id])
  end
end
