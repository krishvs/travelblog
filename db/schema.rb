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

ActiveRecord::Schema.define(version: 20140815102030) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "addresses", force: true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "map_id"
  end

  create_table "blogs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   default: 0
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          default: 0, null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "costs", force: true do |t|
    t.string   "item"
    t.float    "price"
    t.float    "count"
    t.integer  "folder_id"
    t.integer  "mode"
    t.text     "description"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costs", ["folder_id"], name: "index_costs_on_folder_id", using: :btree

  create_table "descriptions", force: true do |t|
    t.integer  "folder_id"
    t.text     "description"
    t.string   "title"
    t.integer  "mode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "descriptions", ["folder_id"], name: "index_descriptions_on_folder_id", using: :btree

  create_table "discussions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discussables_id"
    t.string   "discussables_type"
    t.text     "description"
  end

  create_table "documents", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.integer  "folder_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["folder_id"], name: "index_documents_on_folder_id", using: :btree

  create_table "folders", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.integer  "trip_id"
    t.float    "total_cost"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_index "folders", ["trip_id"], name: "index_folders_on_trip_id", using: :btree

  create_table "folders_folders", force: true do |t|
    t.integer "folder_id"
  end

  add_index "folders_folders", ["folder_id"], name: "index_folders_folders_on_folder_id", using: :btree

  create_table "itenaries", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "short_description"
    t.integer  "mode"
  end

  create_table "maps", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.text     "description"
    t.integer  "transport"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sub_maps_id"
    t.string   "sub_maps_type"
    t.text     "url"
  end

  create_table "photos", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "album"
  end

  add_index "photos", ["folder_id"], name: "index_photos_on_folder_id", using: :btree

  create_table "plans", force: true do |t|
    t.datetime "date_time"
    t.string   "name"
    t.integer  "itenary_id"
    t.text     "short_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "descriptions"
    t.decimal  "price_cent",        precision: 10, scale: 0
  end

  create_table "reminders", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.text     "description"
    t.integer  "sent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "folder_id"
  end

  create_table "routes", force: true do |t|
    t.integer  "folder_id"
    t.integer  "mode"
    t.string   "start"
    t.string   "end"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "routes", ["folder_id"], name: "index_routes_on_folder_id", using: :btree

  create_table "routes_routes", force: true do |t|
    t.integer "route_id"
  end

  add_index "routes_routes", ["route_id"], name: "index_routes_routes_on_route_id", using: :btree

  create_table "templates", force: true do |t|
    t.text     "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "trips", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "owner"
  end

  create_table "trips_users", force: true do |t|
    t.integer "trip_id"
    t.integer "user_id"
  end

  create_table "user_actions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "domain"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
