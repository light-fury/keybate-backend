class AttendeesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "attendees_#{params[:event_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
