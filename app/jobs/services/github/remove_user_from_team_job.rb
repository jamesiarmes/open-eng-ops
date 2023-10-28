# frozen_string_literal: true

# Job to remove a user from a GitHub team.
class Services::Github::RemoveUserFromTeamJob < ApplicationJob
  queue_as :default

  # @param config [Services::Github::UserConfig]
  # @param service [Services::Github]
  # @param team_id [Integer]
  # @param github_team_id [Integer]
  #
  # If a user belongs to another team that's related to this Github team, they
  # won't be removed.
  #
  # @todo When should we remove the user from the organization?
  def perform(config:, service:, team_id:, github_team_id:)
    return if !config.username ||
              config.user.teams.where.not(id: team_id)
                    .with_github_team(github_team_id).present?

    service.remove_team_member(github_team_id, config.username)
    Rails.logger.info "Removed #{config.username} from GitHub team #{github_team_id}"
  end
end
