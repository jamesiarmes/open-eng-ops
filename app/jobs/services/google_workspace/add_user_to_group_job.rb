# frozen_string_literal: true

# Job to add a user to a Google Group.
class Services::GoogleWorkspace::AddUserToGroupJob < ApplicationJob
  queue_as :default

  # @param user [User]
  # @param service [Services::GoogleWorkspace]
  # @param group_id [String]
  def perform(user:, service:, group_id:)
    service.add_group_member(group_id, user)
    Rails.logger.info "Added #{user.name} to Google Group #{group_id}"
  end
end
