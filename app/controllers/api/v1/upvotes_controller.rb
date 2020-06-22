class Api::V1::UpvotesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_upvote, only: :destroy
  respond_to :json

  def create
    if current_question.upvotes.exists?(user_id: current_api_v1_user.id)
      @upvote = current_question.upvotes.find_by(user_id: current_api_v1_user.id)
      return @upvote
    end

    @upvote = current_question.upvotes.new(user_id: current_api_v1_user.id)
    authorize @upvote

    if @upvote.save!
      ActionCable.server.broadcast "upvotes_#{current_question.room.id}",
        action: 'create',
        question_id: current_question.id,
        upvotes_count: current_question.upvotes_count,
        event_upvotes_count: current_question.event.upvotes_count,
        upvote_id: @upvote.id
      head :ok
    end

    if current_question.upvotes_count == 1 || current_question.upvotes_count == 5
      message = current_question.upvotes_count == 1 ? 'Great, your question has received a first like!' : 'Awesome, your question has received more than 5 likes!'
      Notification.create!(
        title: 'New like',
        question_id: current_question.id,
        event_id: current_question.event_id,
        room_id: current_question.room_id,
        description: message,
        user: current_question.user
      )
    end
  end

  def destroy
    authorize @upvote

    if @upvote.destroy!
      ActionCable.server.broadcast "upvotes_#{current_question.room.id}",
        action: 'destroy',
        question_id: current_question.id,
        upvotes_count: current_question.upvotes_count,
        event_upvotes_count: current_question.event.upvotes_count
      head :ok
    end
  end

  private

  def current_question
    Question.find_by!(id: params[:question_id], room_id: params[:room_id])
  end

  def set_upvote
    @upvote = current_question.upvotes.find_by(user_id: params[:id])
  end
end
