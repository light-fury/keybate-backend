class EventUser < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: :event_users_count
  has_many :event_user_rooms
  has_many :rooms, through: :event_user_rooms
end
