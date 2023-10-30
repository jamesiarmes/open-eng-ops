# frozen_string_literal: true

class Services::GoogleWorkspace::TeamGroupConfig < ApplicationRecord
  belongs_to :team
  belongs_to :service

  validates :group_id, presence: true

  after_create :queue_add_members
  after_destroy :queue_remove_members

  def self.table_name
    'services_google_workspace_team_group_configs'
  end

  def google_group
    service.group(group_id)
  end

  def team_member_added(user)
    Services::GoogleWorkspace::AddUserToGroupJob.perform_later(
      user:, service:, group_id:
    )
  end

  def team_member_removed(user)
    Services::GoogleWorkspace::RemoveUserFromGroupJob.perform_later(
      user:, service:, group_id:, team_id:
    )
  end

  private

  def queue_add_members
    team.users.each do |member|
      team_member_added(member)
    end
  end

  def queue_remove_members
    team.users.each do |member|
      team_member_removed(member)
    end
  end
end
