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

ActiveRecord::Schema.define(version: 2019_03_07_102739) do

  create_table "active_flags_flags", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.integer "subject_id"
    t.string "subject_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id", "subject_type"], name: "index_active_flags_flags_on_subject_id_and_subject_type"
  end

  create_table "flats", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
  end

end
