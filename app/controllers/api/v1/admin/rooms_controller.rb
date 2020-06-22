class Api::V1::Admin::RoomsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_room, only: [:show, :update, :destroy, :clear_display,
                                  :hide_questions, :show_questions, :allow_microphone_requests]
  respond_to :json

  def create
    @room = current_event.rooms.new(room_params)
    authorize @room
    @room.save!
  end

  def show
    authorize @room
  end

  def update
    authorize @room
    if @room.update!(room_update_params)
      ActionCable.server.broadcast "rooms_#{@room.event_id}",
        action: 'update',
        id: @room.id,
        event_id: @room.event_id,
        name: @room.name,
        color: @room.color,
        auto_allow_questions: @room.auto_allow_questions,
        displayed_poll: @room.displayed_poll,
        dp_background_color: @room.dp_background_color,
        dp_text_color: @room.dp_text_color,
        dp_display_kb_logo: @room.dp_display_kb_logo,
        dp_display_room_info: @room.dp_display_room_info,
        dp_display_multiple_questions: @room.dp_display_multiple_questions,
        dp_display_attendee_info: @room.dp_display_attendee_info
      head :ok
    end
  end

  def destroy
    authorize @room
    @room.destroy!
  end

  def clear_display
    authorize @room
    @room.questions.where(displayed: true).each do |question|
      if question.update!(displayed: false)
        ActionCable.server.broadcast "questions_#{@room.id}",
          action: 'display',
          id: question.id,
          user_id: question.user_id,
          event_id: question.event_id,
          room_id: question.room_id,
          displayed: question.displayed,
          time_displayed: question.time_displayed
        head :ok
      end
    end

    if @room.update!(displayed_poll: nil)
      ActionCable.server.broadcast "rooms_#{@room.event_id}",
        action: 'clear_display',
        id: @room.id,
        event_id: @room.event_id,
        displayed_poll: @room.displayed_poll
      head :ok
    end
  end

  def hide_questions
    authorize @room
    @room.questions.each do |question|
      question.update!(hidden: true, sent_to_bottom: false, displayed: false, pinned_to_top: false)
    end
    ActionCable.server.broadcast "rooms_#{@room.event_id}",
      action: 'hide_questions',
      event_id: @room.event_id,
      room_id: @room.id
    head :ok
  end

  def show_questions
    authorize @room
    @room.questions.each do |question|
      question.update!(hidden: false, sent_to_bottom: false, displayed: false, pinned_to_top: false)
    end
    ActionCable.server.broadcast "rooms_#{@room.event_id}",
      action: 'show_questions',
      event_id: @room.event_id,
      room_id: @room.id
    head :ok
  end

  def allow_microphone_requests
    authorize @room
    @room.toggle!(:allow_microphone_requests)

    ActionCable.server.broadcast "rooms_#{@room.event_id}",
      action: 'toggle_allow_microphone_requests',
      event_id: @room.event_id,
      room_id: @room.id,
      allow_microphone_requests: @room.allow_microphone_requests
    head :ok
  end


  private

  def room_params
    params.permit(:name, :color , :event_id, :auto_allow_questions, :dp_background_color, :dp_text_color, :dp_display_kb_logo, :dp_display_room_info, :dp_display_multiple_questions, :dp_display_attendee_info, :allow_microphone_requests)
  end

  def room_update_params
    params.permit(:name, :color, :auto_allow_questions, :dp_background_color, :dp_text_color, :dp_display_kb_logo, :dp_display_room_info, :dp_display_multiple_questions, :dp_display_attendee_info, :displayed_poll, :allow_microphone_requests)
  end

  def current_event
    Event.find(params[:event_id])
  end

  def set_room
    @room = current_event.rooms.includes(:questions).find(params[:id])
  end
end
