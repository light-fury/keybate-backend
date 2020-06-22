class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_notification, only: [:show, :destroy, :mark_as_read]
  respond_to :json

  def index
    @notifications = current_api_v1_user.notifications.includes(:contact)
  end

  def show
  end

  def destroy
    @notification.destroy!
  end

  def mark_as_read
    @notification.update!(read: true)
  end

  private

  def set_notification
    @notification = current_api_v1_user.notifications.find(params[:id])
  end
end
