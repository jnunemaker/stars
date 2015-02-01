class CreateUserStarEvents < ActiveRecord::Migration
  def change
    create_table :user_star_events do |t|
      t.integer :state, null: false, default: 1, limit: 1
      t.integer :user_id, null: false
      t.integer :star_event_id, null: false
      t.timestamps null: false
    end
    add_index :user_star_events, [:user_id, :star_event_id], unique: true
  end
end
