class Api::V1::Admin::QuestionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_question, only: [:hide, :display, :pin, :send_to_bottom, :allow, :remove, :call, :hangup]
  respond_to :json

  def index
    @questions = current_room.questions
    authorize @questions.first if @questions.first
  end

  def hide
    authorize @question
    if @question.update!(hidden: !@question.hidden, sent_to_bottom: false, displayed: false, pinned_to_top: false)
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'hide',
        id: @question.id,
        user_id: @question.user_id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        hidden: @question.hidden
      head :ok
    end
  end

  def display
    authorize @question
    if @question.update!(displayed: !@question.displayed, time_displayed: DateTime.current, sent_to_bottom: false)
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'display',
        id: @question.id,
        user_id: @question.user_id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        displayed: @question.displayed,
        time_displayed: @question.time_displayed
      head :ok
    end
  end

  def pin
    authorize @question
    if @question.update!(pinned_to_top: !@question.pinned_to_top, time_pinned: DateTime.current, sent_to_bottom: false)
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'pin',
        id: @question.id,
        user_id: @question.user_id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        pinned_to_top: @question.pinned_to_top,
        time_pinned: @question.time_pinned
      head :ok
    end
  end

  def send_to_bottom
    authorize @question
    if @question.update!(sent_to_bottom: !@question.sent_to_bottom, displayed: false, pinned_to_top: false)
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'send_to_bottom',
        id: @question.id,
        user_id: @question.user_id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        sent_to_bottom: @question.sent_to_bottom
      head :ok
    end
  end

  def allow
    authorize @question
    if @question.update!(allowed: true)
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'allow',
        id: @question.id,
        user_id: @question.user_id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        message: @question.message,
        upvotes_count: @question.upvotes_count,
        hidden: @question.hidden,
        deleted: @question.deleted,
        allowed: @question.allowed,
        created_at: @question.created_at
      head :ok
    end
  end

  def remove
    authorize @question
    if @question.update!(deleted: true, sent_to_bottom: false, displayed: false, pinned_to_top: false)
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'remove',
        id: @question.id,
        user_id: @question.user_id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        deleted: @question.deleted
      head :ok
    end
  end

  def call
    authorize @question
    current_room.update(question_under_call: @question.id)

    ActionCable.server.broadcast "questions_#{current_room.id}",
      action: 'start_call',
      id: @question.id,
      user_id: @question.user_id,
      event_id: @question.event_id,
      room_id: @question.room_id,
      data: params[:data]

    Notification.create!(
      title: 'New call',
      question_id: @question.id,
      event_id: @question.event_id,
      room_id: @question.room_id,
      description: "You were asked to take the floor by the moderator.",
      user: @question.user,
      data: params[:data]
    )
  end

  def hangup
    authorize @question
    
    @question.update!(callable: false)
    current_room.update(question_under_call: nil)

    ActionCable.server.broadcast "questions_#{current_room.id}",
      action: 'end_call',
      id: @question.id,
      user_id: @question.user_id,
      event_id: @question.event_id,
      room_id: @question.room_id,
      data: params[:data]
  end

  private

  def current_room
    Room.find_by!(id: params[:room_id], event_id: params[:event_id])
  end

  def set_question
    @question = current_room.questions.find(params[:id])
  end
end
