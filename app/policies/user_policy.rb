class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def create?
    admin? || has_permissions('create_users')
  end

  def destroy?
    admin? || has_permissions('delete_users')
  end

  def index?
    admin? || has_permissions('index_users')
  end

  def show?
    admin? || has_permissions('view_users')
  end

  def update?
    admin? || has_permissions('edit_users')
  end
end
