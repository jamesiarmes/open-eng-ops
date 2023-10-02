class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def create?
    admin? || has_permissions('create_services')
  end

  def destroy?
    admin? || has_permissions('delete_services')
  end

  def index?
    admin? || has_permissions('list_services')
  end

  def show?
    admin? || has_permissions('view_services')
  end

  def update?
    admin? || has_permissions('edit_services')
  end
end
