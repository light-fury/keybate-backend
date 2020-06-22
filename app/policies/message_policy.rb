class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.has_role? :contact, record.contact.to_user or user.has_role? :contact, record.contact.from_user
  end

  def create?
    user.has_role? :contact, record.contact.to_user or user.has_role? :contact, record.contact.from_user
  end

  def show?
    user.has_role? :contact, record.contact.to_user or user.has_role? :contact, record.contact.from_user
  end

  def update?
    user.has_role? :contact, record.contact.to_user or user.has_role? :contact, record.contact.from_user
  end

  def destroy?
    user.has_role? :contact, record.contact.to_user or user.has_role? :contact, record.contact.from_user
  end

  def mark_as_read?
    user.has_role? :contact, record.contact.to_user or user.has_role? :contact, record.contact.from_user
  end

end
