class PollOption < ApplicationRecord
  belongs_to :poll, counter_cache: :options_count

  validates :description, presence: true

  def answers
    PollAnswer.where(option_id: self.id)
  end
end
