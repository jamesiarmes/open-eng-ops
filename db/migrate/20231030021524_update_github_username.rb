# frozen_string_literal: true

class UpdateGithubUsername < ActiveRecord::Migration[7.1]
  def self.up
    add_column :services_github_user_configs, :github_user_id, :integer

    # Lookup the github_user_id for each username and store it before we remove
    # the column.
    service = Services::Github.first
    Services::Github::UserConfig.all.each do |config|
      config.github_user_id = service.user(config.username).id
      config.save
    end

    remove_column :services_github_user_configs, :username
  end

  def down
    add_column :services_github_user_configs, :username, :string

    # Lookup the username for each github_user_id and store it before we
    # remove the column.
    service = Services::Github.first
    Services::Github::UserConfig.all.each do |config|
      config.username = service.user(config.github_user_id).login
      config.save
    end

    remove_column :services_github_user_configs, :github_user_id
  end
end
