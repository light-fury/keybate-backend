class QcmPoll < ApplicationRecord
  belongs_to :moderator
  belongs_to :room
  has_many :qcm_polls, through: :answered_polls

  validates :question, presence: true

  before_update   :check_for_sending_out


  private

    def check_for_sending_out
      send_out = self.sent_out_changed?

      if send_out
        Pusher.trigger('updates', 'polls', {
          type: 'qcm',
          action: 'send',
          id: self.id,
          room_id: self.room_id,
          moderator_id: self.moderator_id,
          question: self.question,
          option_a: self.option_a,
          option_b: self.option_b,
          option_c: self.option_c,
          option_d: self.option_d
        })
      end
    end
end
