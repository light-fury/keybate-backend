class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.has_role? :room_attendee, record.poll.room
  end

  def create?
    user.has_role? :room_attendee, record.poll.room
  end

  def show?
    user.has_role? :room_attendee, record.poll.room
  end

  def update?
    user.has_role? :room_attendee, record.poll.room
  end

  def destroy?
    user.has_role? :room_attendee, record.poll.room
  end

end
