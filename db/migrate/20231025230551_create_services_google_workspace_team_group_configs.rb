# frozen_string_literal: true

class CreateServicesGoogleWorkspaceTeamGroupConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :services_google_workspace_team_group_configs do |t|
      t.belongs_to :team
      t.belongs_to :service
      t.string :group_id, null: false

      t.timestamps
    end
  end
end
