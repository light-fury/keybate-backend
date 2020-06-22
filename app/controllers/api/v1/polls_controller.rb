class Api::V1::PollsController < ApplicationController
  before_action :authenticate_api_v1_user!
  respond_to :json

  def index
    @polls = current_room.polls.includes(:answers, :options).where(published: true)
    authorize @polls.first if @polls.first
  end

  def show
    @poll = current_room.polls.includes(:answers, :options).find(params[:id])
    authorize @poll
  end

  private

  def current_room
    Room.includes(:polls).find_by!(id: params[:room_id], event_id: params[:event_id])
  end
end
