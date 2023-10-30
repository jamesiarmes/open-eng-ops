# frozen_string_literal: true

class CreateServicesGoogleWorkspaceUserConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :services_google_workspace_user_configs do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :service, null: false, foreign_key: true
      t.string :google_user_id, null: false

      t.timestamps
    end
  end
end
