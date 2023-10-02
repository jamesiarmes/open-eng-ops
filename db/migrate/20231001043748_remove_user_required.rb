class RemoveUserRequired < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :name, :text, null: true
    change_column :users, :pronouns, :text, null: true
  end

  def down
    change_column :users, :name, :text, null: false
    change_column :users, :pronouns, :text, null: false
  end
end
