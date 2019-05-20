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

ActiveRecord::Schema.define(version: 2019_05_20_211023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer "result_team_1"
    t.integer "result_team_2"
    t.string "result"
    t.string "integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "match_id"
    t.index ["match_id"], name: "index_bets_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "team_1_name"
    t.string "team_2_name"
    t.integer "team_1_result"
    t.integer "team_2_result"
    t.integer "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
  end

  create_table "pollas", force: :cascade do |t|
    t.integer "valid_polla"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "transaction_id"
    t.bigint "user_id"
    t.index ["transaction_id"], name: "index_pollas_on_transaction_id"
    t.index ["user_id"], name: "index_pollas_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "amount"
    t.string "bank"
    t.integer "bank_account_number"
    t.integer "payment_id"
    t.string "payment_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone_number"
  end

  add_foreign_key "bets", "matches"
  add_foreign_key "pollas", "transactions"
  add_foreign_key "pollas", "users"
  add_foreign_key "transactions", "users"
end
