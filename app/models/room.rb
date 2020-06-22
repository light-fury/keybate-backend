class Room < ApplicationRecord
  resourcify

  belongs_to :event
  has_many :polls
  has_many :questions
  has_many :event_user_rooms
  has_many :event_users, through: :event_user_rooms
  has_many :users, through: :event_users
  has_many :notifications

  validates :name, presence: true
end
