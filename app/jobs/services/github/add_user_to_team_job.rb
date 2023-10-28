# frozen_string_literal: true

# Job to add a user to a GitHub organization and team.
class Services::Github::AddUserToTeamJob < ApplicationJob
  queue_as :default

  # @param config [Services::Github::UserConfig]
  # @param service [Services::Github]
  # @param github_team_id [Integer]
  def perform(config:, service:, github_team_id:)
    return unless config.username

    unless service.organization_member?(config.username)
      service.update_organization_membership(config.username)
      Rails.logger.info "Invited #{config.username} to GitHub organization #{service.config[:org]}"
    end

    unless service.team_member?(github_team_id, config.username)
      service.add_team_member(github_team_id, config.username)
      Rails.logger.info "Invited #{config.username} to GitHub team #{github_team_id}"
    end
  end
end
