class PollAnswer < ApplicationRecord
  belongs_to :poll, counter_cache: :answers_count
  belongs_to :user
  belongs_to :option, class_name: 'PollOption'

  validates :poll, uniqueness: { scope: :user_id }

  def self.policy_class
    AnswerPolicy
  end
end
