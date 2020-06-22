class UpvotesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "upvotes_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
