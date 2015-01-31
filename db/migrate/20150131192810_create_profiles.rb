class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.integer :provider_id, null: false
      t.string :uid, null: false
      t.string :nickname, null: false
      t.string :token
      t.string :secret
      t.boolean :expires
      t.timestamp :expires_at
      t.timestamps
    end

    add_index :profiles, :user_id
    add_index :profiles, [:uid, :provider_id], unique: true
  end
end
