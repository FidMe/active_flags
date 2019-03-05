# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_05_091129) do

  create_table "active_flags_flags", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.integer "subject_id"
    t.string "subject_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id", "subject_type"], name: "index_active_flags_flags_on_subject_id_and_subject_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
  end

end
