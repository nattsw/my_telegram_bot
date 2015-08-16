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

ActiveRecord::Schema.define(version: 20150816092919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "group_chats", force: :cascade do |t|
    t.string "title"
  end

  create_table "group_chats_users", force: :cascade do |t|
    t.integer "group_chat_id"
    t.integer "user_id"
  end

  add_index "group_chats_users", ["group_chat_id"], name: "index_group_chats_users_on_group_chat_id", using: :btree
  add_index "group_chats_users", ["user_id"], name: "index_group_chats_users_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "date"
    t.integer  "group_chats_user_id"
    t.integer  "forward_date"
    t.string   "text"
    t.boolean  "audio"
    t.boolean  "document"
    t.boolean  "photo"
    t.boolean  "sticker"
    t.boolean  "video"
    t.boolean  "voice"
    t.string   "caption"
    t.boolean  "contact"
    t.integer  "location_id"
    t.string   "new_chat_title"
    t.boolean  "new_chat_photo"
    t.boolean  "delete_chat_photo"
    t.boolean  "group_chat_created"
  end

  add_index "messages", ["group_chats_user_id"], name: "index_messages_on_group_chats_user_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
  end

  add_foreign_key "messages", "group_chats_users"
  add_foreign_key "messages", "messages"
  add_foreign_key "messages", "users"
end
