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

ActiveRecord::Schema.define(version: 2020_09_26_061824) do

  create_table "skicker_users", force: :cascade do |t|
    t.integer "skicker_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["skicker_id"], name: "index_skicker_users_on_skicker_id"
    t.index ["user_id"], name: "index_skicker_users_on_user_id"
  end

  create_table "skickers", force: :cascade do |t|
    t.string "name"
    t.integer "power"
    t.integer "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sukipis", force: :cascade do |t|
    t.string "name"
    t.integer "suki"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_sukipis_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "skicker_users", "skickers"
  add_foreign_key "skicker_users", "users"
  add_foreign_key "sukipis", "users"
end
