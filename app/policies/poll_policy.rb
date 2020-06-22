class PollPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.has_role? :event_moderator, record.event or user.has_role? :room_attendee, record.room
  end

  def create?
    user.has_role? :event_moderator, record.event
  end

  def show?
    user.has_role? :event_moderator, record.event or user.has_role? :room_attendee, record.room
  end

  def update?
    user.has_role? :event_moderator, record.event
  end

  def destroy?
    user.has_role? :event_moderator, record.event
  end

  def reorder?
    user.has_role? :event_moderator, record.event
  end

  def publish?
    user.has_role? :event_moderator, record.event
  end

  def open?
    user.has_role? :event_moderator, record.event
  end

  def display_results?
    user.has_role? :event_moderator, record.event
  end

  def destroy_option?
    user.has_role? :event_moderator, record.event
  end

end
