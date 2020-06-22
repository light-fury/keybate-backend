class Poll < ApplicationRecord
  belongs_to :room
  belongs_to :event
  has_many :options, class_name: 'PollOption', dependent: :destroy
  has_many :answers, class_name: 'PollAnswer', dependent: :destroy
  has_many :notifications
  accepts_nested_attributes_for :options

  validates :title, presence: true

  # Reorder polls that are saved but not published in the moderator panel poll menu once one of those polls is published.
  def reorder_after_publish(room, list_order)
    room.polls.each do |poll|
      if poll.list_order != nil && poll.list_order > list_order
        new_order = poll.list_order - 1
        poll.update_attribute(:list_order, new_order)

        ActionCable.server.broadcast "polls_#{room.id}",
          action: 'reorder',
          id: poll.id,
          list_order: poll.list_order
      end
    end
  end
end
