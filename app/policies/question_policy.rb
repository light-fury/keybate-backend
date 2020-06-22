class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.has_role?(:event_moderator, record.event) || user.has_role?(:room_attendee, record.room)
  end

  def hide?
    user.has_role? :event_moderator, record.event
  end

  def display?
    user.has_role? :event_moderator, record.event
  end

  def pin?
    user.has_role? :event_moderator, record.event
  end

  def send_to_bottom?
    user.has_role? :event_moderator, record.event
  end

  def allow?
    user.has_role? :event_moderator, record.event
  end

  def remove?
    user.has_role? :event_moderator, record.event
  end

  def call?
    user.has_role? :event_moderator, record.event
  end

  def hangup?
    user.has_role?(:event_moderator, record.event) || user.has_role?(:room_attendee, record.room)
  end

  def create?
    user.has_role? :room_attendee, record.room
  end

  def show?
    user.has_role? :room_attendee, record.room
  end

  def update?
    user.has_role? :room_attendee, record.room
  end

  def destroy?
    user.has_role? :room_attendee, record.room
  end
end
