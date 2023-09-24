class RolePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def create?
    admin? || has_permissions('create_roles')
  end

  def destroy?
    admin? || has_permissions('delete_roles')
  end

  def index?
    admin? || has_permissions('index_roles')
  end

  def show?
    admin? || has_permissions('view_roles')
  end

  def update?
    admin? || has_permissions('edit_roles')
  end

  private

  def has_permissions(permission)
    user.permissions.exists?(name: permission)
  end
end
