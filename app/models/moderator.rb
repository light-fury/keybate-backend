class Moderator < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :qcm_polls
end
