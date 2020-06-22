class SignalsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "signals_#{params[:room_id]}"
  end

  def receive(data)
    if data['event'] == 'close_call'
      ActionCable.server.broadcast("call_closed", data)
    else
      ActionCable.server.broadcast("attendee_info_#{params[:room_id]}", data)
    end
  end
end
