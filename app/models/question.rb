class Question < ApplicationRecord
  belongs_to :event, counter_cache: :questions_count
  belongs_to :room
  belongs_to :user, counter_cache: :questions_count
  has_many :upvotes, class_name: 'QuestionUpvote'
  has_many :notifications

  validates :message, presence: true
end
