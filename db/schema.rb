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

ActiveRecord::Schema.define(version: 20170407021245) do

  create_table "appointments", force: :cascade do |t|
    t.integer  "resident_id", limit: 4
    t.integer  "doctor_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.date     "date"
    t.time     "time"
    t.text     "notes",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "apt_type",    limit: 255
    t.boolean  "cancel"
  end

  add_index "appointments", ["doctor_id"], name: "index_appointments_on_doctor_id", using: :btree
  add_index "appointments", ["resident_id"], name: "index_appointments_on_resident_id", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "apt_types", force: :cascade do |t|
    t.string   "apt_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "for",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",      limit: 255
  end

  add_index "cars", ["user_id"], name: "index_cars_on_user_id", using: :btree

  create_table "doctors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "address",     limit: 255
    t.string   "phone",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doctor_type", limit: 255
  end

  create_table "houses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",      limit: 255
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recurring_reminders", force: :cascade do |t|
    t.integer  "appointment_id",    limit: 4
    t.date     "notification_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "start"
    t.datetime "finish"
    t.integer  "user_id",    limit: 4
    t.integer  "car_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note",       limit: 65535
  end

  create_table "residents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "house_id",   limit: 4
    t.text     "notes",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "residents", ["house_id"], name: "index_residents_on_house_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.integer  "volunteer_id",           limit: 4
    t.boolean  "approved"
    t.string   "phone",                  limit: 255
    t.integer  "house_id",               limit: 4
    t.string   "name",                   limit: 255
    t.boolean  "email_pref",                         default: false
    t.boolean  "medical_coordinator",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
