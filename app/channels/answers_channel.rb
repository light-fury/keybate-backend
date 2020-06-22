class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "answers_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
