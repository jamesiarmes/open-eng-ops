# frozen_string_literal: true

class Services::GoogleWorkspace::TeamGroupConfig < ApplicationRecord
  belongs_to :team
  belongs_to :service

  def self.table_name
    'services_google_workspace_team_group_configs'
  end

  def google_group
    service.group(group_id)
  end
end
