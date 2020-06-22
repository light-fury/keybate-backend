class Message < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  has_many :notifications

  validates :body, presence: true
end
