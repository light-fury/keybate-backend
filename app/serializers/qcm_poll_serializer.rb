class QcmPollSerializer < ActiveModel::Serializer
  attributes :id, :question, :option_a, :option_a_score, :option_b,
             :option_b_score, :option_c, :option_c_score, :option_d,
             :option_d_score, :moderator_id, :room_id, :created_at, :sent_out,
             :total_answers

  # embed :ids

  has_one :moderator
  has_one :room
end
