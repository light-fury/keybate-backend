class PollsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "polls_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
