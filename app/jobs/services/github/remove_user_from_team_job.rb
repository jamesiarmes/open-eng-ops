# frozen_string_literal: true

# Job to remove a user toa GitHub team.
class Services::Github::RemoveUserFromTeamJob < ApplicationJob
  queue_as :default

  # @param config [Services::Github::UserConfig]
  # @param relation [Services::Github::TeamConfig]
  #
  # @todo When should we remove the user from the organization?
  def perform(config:, relation:)
    return unless config.username

    relation.service.remove_team_member(relation.github_team_id, config.username)
    Rails.logger.info "Removed #{config.username} from GitHub team #{relation.github_team_id}"
  end
end
