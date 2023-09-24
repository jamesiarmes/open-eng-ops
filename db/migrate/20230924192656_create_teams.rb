class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, unique: true
      t.string :human_name
      t.text :description

      t.timestamps
    end

    create_table :team_members do |t|
      t.belongs_to :team
      t.belongs_to :user
    end

    add_index(:team_members, %i[user_id team_id], unique: true)
  end
end
