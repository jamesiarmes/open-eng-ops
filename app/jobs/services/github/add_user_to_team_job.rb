# frozen_string_literal: true

# Job to add a user toa GitHub organization and team.
class Services::Github::AddUserToTeamJob < ApplicationJob
  queue_as :default

  # @param config [Services::Github::UserConfig]
  # @param relation [Services::Github::TeamToTeam]
  def perform(config:, relation:)
    return unless config.username

    unless relation.service.organization_member?(config.username)
      relation.service.update_organization_membership(config.username)
      Rails.logger.info "Invited #{config.username} to GitHub organization #{relation.service.config[:org]}"
    end

    unless relation.service.team_member?(relation.github_team_id, config.username)
      relation.service.add_team_member(relation.github_team_id, config.username)
      Rails.logger.info "Invited #{config.username} to GitHub team #{relation.github_team_id}"
    end
  end
end
