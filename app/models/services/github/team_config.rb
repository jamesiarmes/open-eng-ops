class Services::Github::TeamConfig < ApplicationRecord
  belongs_to :team
  belongs_to :service

  def self.table_name
    'services_github_team_configs'
  end

  def github_team
    @github_team ||= service.team(github_team_id)
  end

  def github_team_children
    @github_team_children ||= service.client.child_teams(github_team_id)
  end
end
