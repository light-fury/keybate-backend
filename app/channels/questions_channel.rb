class QuestionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "questions_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
