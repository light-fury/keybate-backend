class AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.has_role? :event_moderator, record.room.event or user.has_role? :room_attendee, record.room
  end
end
