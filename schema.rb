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

ActiveRecord::Schema.define(version: 20141005160625) do

  create_table "appointments", force: true do |t|
    t.integer  "resident_id"
    t.integer  "physician_id"
    t.integer  "volunteer_id"
    t.date     "date"
    t.time     "time"
    t.string   "for"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cancel"
  end

  add_index "appointments", ["physician_id"], name: "index_appointments_on_physician_id"
  add_index "appointments", ["resident_id"], name: "index_appointments_on_resident_id"
  add_index "appointments", ["volunteer_id"], name: "index_appointments_on_volunteer_id"

  create_table "houses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "physicians", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residents", force: true do |t|
    t.string   "name"
    t.integer  "house_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "residents", ["house_id"], name: "index_residents_on_house_id"

  create_table "volunteers", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "house_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "volunteers", ["house_id"], name: "index_volunteers_on_house_id"

end
