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

ActiveRecord::Schema.define(version: 20130731150155) do

  create_table "commands", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "auth_attribute"
    t.string   "auth_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "installations", force: true do |t|
    t.integer  "screen_id"
    t.integer  "command_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.integer  "screen_id"
    t.integer  "command_id"
    t.text     "arguments"
    t.integer  "user_id"
    t.datetime "target"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "removable"
  end

  create_table "memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "screen_id"
    t.integer  "command_id"
    t.text     "arguments"
    t.integer  "user_id"
    t.integer  "offset"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "screens", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.boolean  "administrator"
    t.string   "name"
    t.string   "email_address"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
