class DefaultRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :default, :boolean, default: false
  end
end
