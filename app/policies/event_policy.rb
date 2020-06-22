class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.has_role? :event_moderator, record or user.has_role? :event_attendee, record
  end

  def show?
    user.has_role? :event_moderator, record or user.has_role? :event_attendee, record
  end

  def update?
    user.has_role? :event_moderator, record
  end

  def destroy?
    user.has_role? :event_moderator, record
  end
end
