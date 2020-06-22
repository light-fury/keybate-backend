class Api::V1::AnswersController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_answer, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @answers = current_poll.answers
    authorize @answers.first if @answers.first
  end

  def create
    @answer = current_poll.answers.new(answer_params)
    authorize @answer
    if @answer.save!
      ActionCable.server.broadcast "answers_#{current_poll.room.id}",
        action: 'create',
        user_id: current_api_v1_user.id,
        poll_id: @answer.poll_id,
        option_id: @answer.option_id,
        poll_answers_count: current_poll.event.poll_answers_count
      head :ok
    end
  end

  def show
    authorize @answer
  end

  def update
    authorize @answer
    @answer.update!(answer_params)
  end

  def destroy
    authorize @answer
    @answer.destroy!
  end

  private

  def answer_params
    params.permit(:poll_id, :option_id).merge(user_id: current_api_v1_user.id)
  end

  def current_poll
    Poll.find(params[:poll_id])
  end

  def set_answer
    @answer = current_poll.answers.find(params[:id])
  end
end
