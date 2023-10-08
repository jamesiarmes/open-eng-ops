class Services::Github::TeamConfig < ApplicationRecord
  belongs_to :team
  belongs_to :service

  after_create :queue_add_members
  after_destroy :queue_remove_members

  def self.table_name
    'services_github_team_configs'
  end

  def github_team
    @github_team ||= service.team(github_team_id)
  end

  def github_team_children
    @github_team_children ||= service.client.child_teams(github_team_id)
  end

  private

  def queue_add_members
    team.users.each do |member|
      next if member.services_github_user_config.blank?

      Services::Github::AddUserToTeamJob.perform_later(
        config: member.services_github_user_config, service:, github_team_id:
      )
    end
  end

  def queue_remove_members
    team.users.each do |member|
      next if member.services_github_user_config.blank?

      Services::Github::RemoveUserFromTeamJob.perform_later(
        config: member.services_github_user_config, service:, team_id:,
        github_team_id:
      )
    end
  end
end
