# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150131230818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "provider_id", null: false
    t.string   "uid",         null: false
    t.string   "nickname",    null: false
    t.string   "token"
    t.string   "secret"
    t.boolean  "expires"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["uid", "provider_id"], name: "index_profiles_on_uid_and_provider_id", unique: true, using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "star_events", force: :cascade do |t|
    t.string   "event_id",   null: false
    t.hstore   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "star_events", ["event_id"], name: "index_star_events_on_event_id", unique: true, using: :btree

  create_table "user_star_events", force: :cascade do |t|
    t.integer  "state",         limit: 2, default: 1, null: false
    t.integer  "user_id",                             null: false
    t.integer  "star_event_id",                       null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "user_star_events", ["user_id", "star_event_id"], name: "index_user_star_events_on_user_id_and_star_event_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
