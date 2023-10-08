class CreateIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :identities do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :service, foreign_key: true
      t.string :provider
      t.string :uid

      # Use a larger limit to account for encryption.
      t.string :token, limit: 510
      t.string :refresh_token, limit: 510

      t.timestamps
    end
  end
end
