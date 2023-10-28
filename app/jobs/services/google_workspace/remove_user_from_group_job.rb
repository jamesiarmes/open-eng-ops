# frozen_string_literal: true

# Job to remove a user from Google Group.
class Services::GoogleWorkspace::RemoveUserFromGroupJob < ApplicationJob
  queue_as :default

  # @param user [User]
  # @param service [Services::GoogleWorkspace]
  # @param group_id [String]
  # @param team_id [Integer]
  #
  # If a user belongs to another team that's related to this Github team, they
  # won't be removed.
  def perform(user:, service:, group_id:, team_id:)
    return if user.teams.where.not(id: team_id)
                  .with_google_group(group_id).present?

    service.remove_group_member(group_id, user)
    Rails.logger.info "Removed #{user.name} from Google Group #{group_id}"
  end
end
