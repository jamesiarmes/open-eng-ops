class CreateServiceGithubUserConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :services_github_user_configs do |t|
      t.belongs_to :user, foreign_key: true
      t.string :username

      t.timestamps
    end
  end
end
