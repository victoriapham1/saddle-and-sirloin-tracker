# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_321_141_114) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'admins', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'full_name'
    t.string 'uid'
    t.string 'avatar_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'access_token'
    t.datetime 'expires_at'
    t.string 'refresh_token'
    t.index ['email'], name: 'index_admins_on_email', unique: true
  end

  create_table 'announcements', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'events', force: :cascade do |t|
    t.string 'name'
    t.date 'date'
    t.integer 'event_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'description'
    t.time 'start_time'
    t.time 'end_time'
    t.string 'google_event_id'
    t.boolean 'isActive', default: true
  end

  create_table 'user_events', force: :cascade do |t|
    t.boolean 'attendance'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.bigint 'event_id'
    t.index ['event_id'], name: 'index_user_events_on_event_id'
    t.index ['user_id'], name: 'index_user_events_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.integer 'uin'
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'phone'
    t.string 'password'
    t.boolean 'isActive', default: false
    t.integer 'role'
    t.integer 'classify'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'isRequesting', default: true
  end

  add_foreign_key 'user_events', 'events'
  add_foreign_key 'user_events', 'users'
end
