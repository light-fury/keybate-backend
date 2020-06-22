class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_message, only: [:show, :update, :destroy, :mark_as_read]
  respond_to :json

  def index
    @messages = current_contact.messages.order(created_at: :asc)
    authorize @messages.first if @messages.first
  end

  def create
    @message = current_contact.messages.new(message_params)
    authorize @message
    @message.blocked = true if current_contact.blocked
    if @message.save!
      if @message.user_id == current_contact.from_user_id
        ActionCable.server.broadcast "messages_#{current_contact.to_user_id}",
          action: 'create',
          contact_id: @message.contact_id,
          body: @message.body,
          sender_id: @message.user_id

        unless current_contact.blocked
          Notification.create!(
            title: 'New message',
            contact_id: @message.contact_id,
            message: @message,
            description: "You have a new message from #{current_contact.from_user.first_name}.",
            user: current_contact.to_user
          )
        end
      else
        ActionCable.server.broadcast "messages_#{current_contact.from_user_id}",
          action: 'create',
          contact_id: @message.contact_id,
          body: @message.body,
          sender_id: @message.user_id

        unless current_contact.blocked
          Notification.create!(
            title: 'New message',
            contact_id: @message.contact_id,
            message: @message,
            description: "You have a new message from #{current_contact.to_user.first_name}.",
            user: current_contact.from_user
          )
        end
      end

      current_contact.update!(last_message_sent_at: DateTime.current)
    end
  end

  def show
    authorize @message
  end

  def update
    authorize @message
    @message.update!(message_params)
  end

  def destroy
    authorize @message
    @message.destroy!
  end

  def mark_as_read
    authorize @message
    @message.update!(read: true)

    ActionCable.server.broadcast "messages_#{@message.user_id}",
      action: 'read',
      id: @message.id
    head :ok
  end

  private

  def message_params
    params.permit(:body).merge(user_id: current_api_v1_user.id)
  end

  def current_contact
    Contact.find(params[:contact_id])
  end

  def set_message
    @message = current_contact.messages.find(params[:id])
  end
end
