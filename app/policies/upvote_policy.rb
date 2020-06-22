class UpvotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.has_role? :room_attendee, record.question.room
  end

  def destroy?
    user.has_role? :room_attendee, record.question.room
  end
end
