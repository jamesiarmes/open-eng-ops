class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def create?
    admin? || has_permissions('create_teams')
  end

  def destroy?
    admin? || has_permissions('delete_teams')
  end

  def index?
    admin? || has_permissions('index_teams')
  end

  def show?
    admin? || has_permissions('view_teams')
  end

  def update?
    admin? || has_permissions('edit_teams')
  end
end
