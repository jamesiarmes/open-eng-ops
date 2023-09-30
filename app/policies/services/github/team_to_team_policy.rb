class Services::Github::TeamToTeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def create?
    admin? || has_permissions('create_service_github_team_to_teams')
  end

  def destroy?
    admin? || has_permissions('delete_service_github_team_to_teams')
  end

  def index?
    admin? || has_permissions('index_service_github_team_to_teams')
  end

  def show?
    admin? || has_permissions('view_service_github_team_to_teams')
  end

  def update?
    admin? || has_permissions('edit_service_github_team_to_teams')
  end
end
