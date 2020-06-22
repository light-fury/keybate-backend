class Attendee < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :questions, dependent: :destroy

  def joined!
    update_attributes! joined_at: DateTime.current
  end

  def left!
    update_attributes! left_at: DateTime.current
  end

  def requested_call!
    update_attributes! requested_call_at: DateTime.current
  end

  def hung_up!
    update_attributes! hung_up_at: DateTime.current
  end
end
