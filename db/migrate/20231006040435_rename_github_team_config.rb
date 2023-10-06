class RenameGithubTeamConfig < ActiveRecord::Migration[7.0]
  def change
    rename_table :services_github_team_to_teams, :services_github_team_configs
  end
end
