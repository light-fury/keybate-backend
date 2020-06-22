class ContactsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "contacts_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
