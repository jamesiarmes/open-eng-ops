class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street1
      t.string :street2
      t.string :locality #city
      t.string :administrative_area #state
      t.string :postal_code
      t.string :country

      t.timestamps
    end

    remove_column :users, :address, :jsonb
    add_reference :users, :address, foreign_key: true
  end
end
