class Api::V1::QcmPollsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_filter :set_qcm_poll, only: [:show, :update]
  respond_to :json

  def index
    if params[:room_id] && params[:moderator_id]
      @qcm_polls = QcmPoll.where(room_id: params[:room_id], moderator_id: params[:moderator_id])
    elsif params[:room_id]
      @qcm_polls  = QcmPoll.where(room_id: params[:room_id])
    elsif params[:moderator_id]
      @qcm_polls  = QcmPoll.where(moderator_id: params[:moderator_id])
    elsif params[:id]
      @qcm_polls = QcmPoll.where(id: params[:id])
    end

    render json: @qcm_polls
  end

  def show
    render json: @qcm_poll, serializer: QcmPollSerializer
  end

  def create
    @qcm_poll = QcmPoll.new(qcm_poll_params)

    if @qcm_poll.save
      if @qcm_poll.sent_out == true
        Pusher.trigger('updates', 'polls', {
          type: 'qcm',
          action: 'send',
          id: @qcm_poll.id,
          room_id: @qcm_poll.room_id,
          moderator_id: @qcm_poll.moderator_id,
          question: @qcm_poll.question,
          option_a: @qcm_poll.option_a,
          option_b: @qcm_poll.option_b,
          option_c: @qcm_poll.option_c,
          option_d: @qcm_poll.option_d
        })
      end

      render json: @qcm_poll, status: :created, location: [:api, @qcm_poll]
    else
      render json: { errors: @qcm_poll.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @qcm_poll.update(qcm_poll_params)
      Pusher.trigger('updates', 'polls', {
        type: 'qcm',
        action: 'update',
        id: @qcm_poll.id,
        room_id: @qcm_poll.room_id,
        moderator_id: @qcm_poll.moderator_id,
        question: @qcm_poll.question,
        option_a_score: @qcm_poll.option_a_score,
        option_b_score: @qcm_poll.option_b_score,
        option_c_score: @qcm_poll.option_c_score,
        option_d_score: @qcm_poll.option_d_score,
        total_answers: @qcm_poll.total_answers
      })

      head :no_content
    else
      render json: { errors: @qcm_poll.errors }, status: :unprocessable_entity
    end
  end


  private

    def set_qcm_poll
      @qcm_poll = QcmPoll.find(params[:id])
    end

    def qcm_poll_params
      params.require(:qcm_poll).permit(:question, :option_a, :option_a_score,
                                       :option_b, :option_b_score, :option_c,
                                       :option_c_score, :option_d,
                                       :option_d_score, :moderator_id, :room_id,
                                       :sent_out, :total_answers)
    end

end
