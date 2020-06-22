class Api::V1::EventsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_event, only: [:show, :join]
  respond_to :json

  def index
    if params[:code]
      @events = Event.where(code: params[:code])
      authorize @events.first
    else
      @events = current_api_v1_user.events
    end
  end

  def show
    authorize @event
  end

  def join
    unless current_api_v1_user.has_role? :event_attendee, @event
      event_user = @event.event_users.new(user_id: current_api_v1_user.id)
      if event_user.save!
        current_api_v1_user.add_role :event_attendee, @event

        ActionCable.server.broadcast "attendees_#{@event.id}",
          action: 'join',
          user_id: event_user.user_id,
          first_name: event_user.user.first_name,
          last_name: event_user.user.last_name,
          position: event_user.user.position,
          location: event_user.user.location,
          picture_url: event_user.user.picture_url,
          event_id: event_user.event_id,
          attendee_count: @event.event_users_count
        head :ok
      end
    end
  end

  private

  def set_event
    if params[:code]
      @event = Event.find_by!(code: params[:code])
    else
      @event = Event.find(params[:id])
    end
  end
end
