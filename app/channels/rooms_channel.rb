class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rooms_#{params[:event_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
