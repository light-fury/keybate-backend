class AnsweredPollSerializer < ActiveModel::Serializer
  attributes :id, :option_letter, :answer_text, :room_name, :qcm_poll_id,
             :user_id, :room_id, :created_at

  has_one :user
  has_one :room
  has_one :qcm_poll
end
