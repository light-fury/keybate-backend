class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_question, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @current_user = current_api_v1_user
    @questions = current_room.questions.where(hidden: false, allowed: true).order(created_at: :desc)
    authorize @questions.first if @questions.first
  end

  def create
    @question = current_room.questions.new(question_params)
    authorize @question

    if current_room.auto_allow_questions == true
      @question.allowed = true
    end
    if @question.save!
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'create',
        id: @question.id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        message: @question.message,
        upvotes_count: @question.upvotes_count,
        displayed: @question.displayed,
        hidden: @question.hidden,
        pinned_to_top: @question.pinned_to_top,
        sent_to_bottom: @question.sent_to_bottom,
        deleted: @question.deleted,
        callable: @question.callable,
        allowed: @question.allowed,
        created_at: @question.created_at,
        questions_count: current_event.questions_count,
        user: {
          id: @question.user_id,
          first_name: @question.user.first_name,
          last_name: @question.user.last_name,
          position: @question.user.position,
          location: @question.user.location,
          picture: {
            full: @question.user.picture_url_full,
            thumbnail: @question.user.picture_url_thumbnail
          }
        }
      head :ok
    end
  end

  def show
    authorize @question
  end

  def update
    authorize @question
    if @question.update!(question_params)
      ActionCable.server.broadcast "questions_#{current_room.id}",
        action: 'update',
        id: @question.id,
        user_id: @question.user_id,
        event_id: @question.event_id,
        room_id: @question.room_id,
        message: @question.message,
        upvotes_count: @question.upvotes_count,
        displayed: @question.displayed,
        hidden: @question.hidden,
        pinned_to_top: @question.pinned_to_top,
        sent_to_bottom: @question.sent_to_bottom,
        deleted: @question.deleted,
        callable: @question.callable,
        allowed: @question.allowed
      head :ok
    end
  end

  def destroy
    authorize @question
    @question.destroy!
  end

  private

  def question_params
    params.permit(:message, :callable, :room_id).merge(user_id: current_api_v1_user.id, event_id: current_event.id)
  end

  def current_room
    Room.find_by!(id: params[:room_id], event_id: params[:event_id])
  end

  def current_event
    Event.find_by!(id: params[:event_id])
  end

  def set_question
    @question = current_room.questions.find(params[:id])
  end
end
