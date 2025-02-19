# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_18_115331) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatmessages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_chatmessages_on_room_id"
    t.index ["user_id"], name: "index_chatmessages_on_user_id"
  end

  create_table "desks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["user_id"], name: "index_desks_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "title"
    t.bigint "desk_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["desk_id"], name: "index_events_on_desk_id"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "date"
    t.string "text"
    t.bigint "user_id", null: false
    t.bigint "desk_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["desk_id"], name: "index_messages_on_desk_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notepads", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "parent_id"
    t.bigint "desk_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["desk_id"], name: "index_notepads_on_desk_id"
    t.index ["parent_id"], name: "index_notepads_on_parent_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.boolean "public"
    t.boolean "locked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "solid_cable_messages", force: :cascade do |t|
    t.text "channel"
    t.text "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel"], name: "index_solid_cable_messages_on_channel"
    t.index ["created_at"], name: "index_solid_cable_messages_on_created_at"
  end

  create_table "spots", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "status", default: 0
    t.index ["room_id"], name: "index_spots_on_room_id"
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chatmessages", "rooms"
  add_foreign_key "chatmessages", "users"
  add_foreign_key "desks", "users"
  add_foreign_key "events", "desks"
  add_foreign_key "messages", "desks"
  add_foreign_key "messages", "users"
  add_foreign_key "notepads", "desks"
  add_foreign_key "rooms", "users"
  add_foreign_key "spots", "rooms"
  add_foreign_key "spots", "users"
end
