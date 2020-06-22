class Api::V1::ContactsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_contact, only: [:show, :update, :destroy, :block, :unblock]
  respond_to :json

  def index
    @contacts = current_api_v1_user.contacts.includes(:messages, :to_user).order(created_at: :desc)
  end

  def create
    @contact = Contact.find_by(from_user_id: params[:to_user_id], to_user_id: current_api_v1_user.id)

    if @contact
      @contact.update!(two_way_contact: true)
      return @contact
    end

    @contact = Contact.new(contact_params)
    authorize @contact

    if @contact.save!
      current_api_v1_user.add_role :contact, @contact.to_user
      @contact.to_user.add_role :contact, @contact.from_user

      ActionCable.server.broadcast "contacts_#{@contact.from_user_id}",
        action: 'create',
        from_user_id: @contact.from_user_id,
        to_user_id: @contact.to_user_id,
        event_contacts_count: @contact.event.contacts_count

      ActionCable.server.broadcast "contacts_#{@contact.to_user_id}",
        action: 'create',
        from_user_id: @contact.from_user_id,
        to_user_id: @contact.to_user_id,
        event_contacts_count: @contact.event.contacts_count
    end
  end

  def show
  end

  def update
    @contact.update!(contact_update_params)
  end

  def destroy
    if @contact.two_way_contact && current_api_v1_user.id == @contact.from_user_id
      current_api_v1_user.remove_role :contact, @contact.to_user
      @contact.update!(from_user_id: @contact.to_user_id, to_user_id: @contact.from_user_id, two_way_contact: false)
    elsif @contact.two_way_contact
      current_api_v1_user.remove_role :contact, @contact.from_user
      @contact.update!(two_way_contact: false)
    else
      current_api_v1_user.remove_role :contact, @contact.to_user
      @contact.destroy!
    end
  end

  def block
    @contact.update!(blocked: true, blocked_by_id: current_api_v1_user.id)
  end

  def unblock
    @contact.update!(blocked: false, blocked_by_id: nil) if current_api_v1_user.id == @contact.blocked_by_id
  end

  def with_messages
    @contacts = current_api_v1_user.contacts.where.not(last_message_sent_at: nil).order(last_message_sent_at: :desc)
  end

  private

  def contact_params
    params.permit(:event_id, :to_user_id).merge(from_user_id: current_api_v1_user.id)
  end

  def contact_update_params
    params.permit(:last_message_sent_at)
  end

  def set_contact
    @contact = Contact.find_by!(id: params[:id])
  end
end
