class Permissions < ActiveRecord::Migration[7.0]
  def change
    create_table(:permissions)  do |t|
      t.string :name
      t.string :controller
      t.text :description
      t.string :controller_method

      t.timestamps

      create_table :roles_permissions, id: false do |t|
        t.references :role, null: false
        t.references :permission, null: false
      end

      add_index(:roles_permissions, [ :permission_id, :role_id ], unique: true)
    end
  end
end
