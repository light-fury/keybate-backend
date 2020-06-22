class Api::V1::AnsweredPollsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_filter :set_answered_poll, only: [:show, :update]
  respond_to :json

  def index
    if params[:room_id] && params[:user_id]
      @answered_polls = AnsweredPoll.where(room_id: params[:room_id], user_id: params[:user_id])
    elsif params[:room_id] && params[:qcm_poll_id]
      @answered_polls = AnsweredPoll.where(room_id: params[:room_id], qcm_poll_id: params[:qcm_poll_id])
    elsif params[:room_id]
      @answered_polls  = AnsweredPoll.where(room_id: params[:room_id])
    elsif params[:user_id]
      @answered_polls  = AnsweredPoll.where(user_id: params[:user_id])
    elsif params[:qcm_poll_id]
      @answered_polls  = AnsweredPoll.where(qcm_poll_id: params[:qcm_poll_id])
    elsif params[:id]
      @answered_polls = AnsweredPoll.where(id: params[:id])
    end

    render json: @answered_polls
  end

  def show
    render json: @answered_poll, serializer: AnsweredPollSerializer
  end

  def create
    @answered_poll = AnsweredPoll.new(answered_poll_params)

    if @answered_poll.save
      render json: @answered_poll, status: :created, location: [:api, @answered_poll]
    else
      render json: { errors: @answered_poll.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @answered_poll.update(answered_poll_params)
      head :no_content
    else
      render json: { errors: @answered_poll.errors }, status: :unprocessable_entity
    end
  end


  private

    def set_answered_poll
      @answered_poll = AnsweredPoll.find(params[:id])
    end

    def answered_poll_params
      params.require(:answered_poll).permit(:option_letter, :answer_text,
                                            :room_name, :qcm_poll_id, :user_id,
                                            :room_id)
    end

end
