class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :room
  belongs_to :question
  belongs_to :poll
  belongs_to :contact
  belongs_to :message

  validates :title, presence: true
  validates :description, presence: true

  after_create :broadcast_create


  private

  def broadcast_create
    ActionCable.server.broadcast "notifications_#{self.user_id}",
      action: 'create',
      id: self.id,
      title: self.title,
      user_id: self.user_id,
      description: self.description,
      read: self.read,
      event_id: self.event_id,
      room_id: self.room_id,
      poll_id: self.poll_id,
      question_id: self.question_id,
      contact_id: self.contact_id,
      message_id: self.message_id,
      created_at: self.created_at,
      updated_at: self.updated_at
  end
end
