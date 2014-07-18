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

ActiveRecord::Schema.define(version: 20140718104249) do

  create_table "addresses", force: true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "map_id"
  end

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

  add_index "costs", ["folder_id"], name: "index_costs_on_folder_id"

  create_table "descriptions", force: true do |t|
    t.integer  "folder_id"
    t.text     "description"
    t.string   "title"
    t.integer  "mode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "descriptions", ["folder_id"], name: "index_descriptions_on_folder_id"

  create_table "documents", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.integer  "folder_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["folder_id"], name: "index_documents_on_folder_id"

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

  add_index "folders", ["trip_id"], name: "index_folders_on_trip_id"

  create_table "folders_folders", force: true do |t|
    t.integer "folder_id"
  end

  add_index "folders_folders", ["folder_id"], name: "index_folders_folders_on_folder_id"

  create_table "maps", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.text     "description"
    t.integer  "transport"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "folder_id"
  end

  create_table "photos", force: true do |t|
    t.string   "name"
    t.integer  "mode"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["folder_id"], name: "index_photos_on_folder_id"

  create_table "reminders", force: true do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "method"
    t.integer  "mode"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reminders", ["folder_id"], name: "index_reminders_on_folder_id"

  create_table "routes", force: true do |t|
    t.integer  "folder_id"
    t.integer  "mode"
    t.string   "start"
    t.string   "end"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "routes", ["folder_id"], name: "index_routes_on_folder_id"

  create_table "routes_routes", force: true do |t|
    t.integer "route_id"
  end

  add_index "routes_routes", ["route_id"], name: "index_routes_routes_on_route_id"

  create_table "trips", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "mode"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
