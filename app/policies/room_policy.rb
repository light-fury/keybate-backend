class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.has_role? :event_moderator, record.event
  end

  def update?
    user.has_role? :event_moderator, record.event
  end

  def destroy?
    user.has_role? :event_moderator, record.event
  end

  def clear_display?
    user.has_role? :event_moderator, record.event
  end

  def hide_questions?
    user.has_role? :event_moderator, record.event
  end

  def show_questions?
    user.has_role? :event_moderator, record.event
  end

  def allow_microphone_requests?
    user.has_role? :event_moderator, record.event
  end

  def index?
    user.has_role? :event_attendee, record.event
  end

  def show?
    user.has_role? :room_attendee, record
  end

  def join?
    user.has_role? :event_attendee, record.event
  end
end
