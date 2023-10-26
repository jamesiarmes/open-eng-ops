# frozen_string_literal: true

class Services::GoogleWorkspace::TeamGroupConfigPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def create?
    admin? || has_permissions('create_service_google_workspace_team_group_configs')
  end

  def destroy?
    admin? || has_permissions('delete_service_google_workspace_team_group_configs')
  end

  def index?
    admin? || has_permissions('index_service_google_workspace_team_group_configs')
  end

  def show?
    admin? || has_permissions('view_service_google_workspace_team_group_configs')
  end

  def update?
    admin? || has_permissions('edit_service_google_workspace_team_group_configs')
  end
end
