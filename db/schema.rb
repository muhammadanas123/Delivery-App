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

ActiveRecord::Schema.define(version: 2022_12_30_065858) do

  create_table "items", force: :cascade do |t|
    t.string "itemname"
    t.integer "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_items_on_order_id"
  end

  create_table "journeys", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.text "departure_date"
    t.text "arrival_date"
    t.integer "capacity"
    t.integer "rate"
    t.integer "traveller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["traveller_id"], name: "index_journeys_on_traveller_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "traveller_id", null: false
    t.integer "sender_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "receiver_name"
    t.integer "receiver_phone"
    t.text "receiver_address"
    t.index ["sender_id"], name: "index_orders_on_sender_id"
    t.index ["traveller_id"], name: "index_orders_on_traveller_id"
  end

  create_table "senders", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.integer "phone_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "landline"
    t.string "city"
    t.string "state"
    t.string "country"
  end

  create_table "travellers", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.integer "phone_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "landline"
    t.string "city"
    t.string "state"
    t.string "country"
  end

  create_table "user_credentials", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_type"
    t.integer "user_id"
    t.index ["email"], name: "index_user_credentials_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_credentials_on_reset_password_token", unique: true
    t.index ["user_type", "user_id"], name: "index_user_credentials_on_user"
  end

  add_foreign_key "items", "orders"
  add_foreign_key "journeys", "travellers"
  add_foreign_key "orders", "senders"
  add_foreign_key "orders", "travellers"
end
