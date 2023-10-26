class CreateServiceGithubTeamToTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :services_github_team_to_teams do |t|
      t.belongs_to :team
      t.belongs_to :service
      t.integer :github_team_id, null: false

      t.timestamps
    end
  end
end
