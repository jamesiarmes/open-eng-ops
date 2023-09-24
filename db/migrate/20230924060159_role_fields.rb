class RoleFields < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :human_name, :string
    add_column :roles, :description, :text
  end
end
