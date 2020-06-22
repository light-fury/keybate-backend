class EventUserRoom < ApplicationRecord
  belongs_to :event_user
  belongs_to :room

  def self.policy_class
    AttendeePolicy
  end
end
