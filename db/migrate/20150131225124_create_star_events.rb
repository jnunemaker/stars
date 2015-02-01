class CreateStarEvents < ActiveRecord::Migration
  def up
    create_table :star_events do |t|
      t.string :event_id, null: false
      t.hstore :source
      t.timestamps null: false
    end

    add_index :star_events, :event_id, unique: true
  end

  def down
    drop_table :star_events
  end
end
