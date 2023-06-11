class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :type
      t.uuid :uuid
      t.jsonb :config

      t.timestamps
    end
  end
end
