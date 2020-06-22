class Api::V1::Admin::EventsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_event, only: [:show, :update, :destroy]
  respond_to :json

  def index
    if params[:code]
      @events = Event.where(code: params[:code])
      authorize @events.first
    else
      @events = current_api_v1_user.moderatored_events
    end
  end

  def create
    @event = Event.create!(event_params)
    @event.event_moderators.create!(user_id: current_api_v1_user.id)
    current_api_v1_user.add_role :event_moderator, @event
  end

  def show
    authorize @event
  end

  def update
    authorize @event
    @event.update!(event_params)
    ActionCable.server.broadcast "events_#{@event.id}",
      action: 'update',
      event_id: @event.id
  end

  def destroy
    authorize @event
    @event.destroy!
  end

  private

  def event_params
    params.permit(:name, :plan, :event_date_start, :event_date_end, :cover,
                  :description, :category, :location, :practical_information,
                  :organizer_contact, :isLive, :event_time_start, :event_time_end,
                  agendas_attributes: [:id, :date, :time_start, :time_end, :title, :_destroy],
                  speakers_attributes: [:id, :name, :affiliation, :picture, :biography, :role, :_destroy],
                  sponsors_attributes: [:id, :name, :contact_email, :picture, :description, :_destroy],
                  rooms_attributes: [:id, :name, :color, :_destroy])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
