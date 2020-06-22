class ContactPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.has_role? :event_attendee, record.event
  end
end
