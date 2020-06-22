class AnsweredPoll < ApplicationRecord
  belongs_to :qcm_poll
  belongs_to :user
  belongs_to :room

  validates :option_letter, presence: true
  validates :answer_text, presence: true

  after_create   :raise_poll_score

  private

    def raise_poll_score
      poll = QcmPoll.find(self.qcm_poll_id)
      option = self.option_letter.downcase
      answers = poll.total_answers + 1

      case option
      when "a"
        score = poll.option_a_score + 1

        if poll.update_attributes(option_a_score: score, total_answers: answers)
          pusher_trigger_updates
        end
      when "b"
        score = poll.option_b_score + 1

        if poll.update_attributes(option_b_score: score, total_answers: answers)
          pusher_trigger_updates
        end
      when "c"
        score = poll.option_c_score + 1

        if poll.update_attributes(option_c_score: score, total_answers: answers)
          pusher_trigger_updates
        end
      when "d"
        score = poll.option_d_score + 1

        if poll.update_attributes(option_d_score: score, total_answers: answers)
          pusher_trigger_updates
        end
      end
    end

    def pusher_trigger_updates
      poll = QcmPoll.find(self.qcm_poll_id)

      Pusher.trigger('updates', 'polls', {
        type: 'qcm',
        action: 'update',
        id: poll.id,
        room_id: poll.room_id,
        moderator_id: poll.moderator_id,
        option_a_score: poll.option_a_score,
        option_b_score: poll.option_b_score,
        option_c_score: poll.option_c_score,
        option_d_score: poll.option_d_score,
        total_answers: poll.total_answers
      })
    end

end
