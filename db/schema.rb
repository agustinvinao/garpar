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

ActiveRecord::Schema[7.0].define(version: 2022_03_03_002425) do
  create_table "addresses", charset: "utf8mb3", force: :cascade do |t|
    t.string "apartment"
    t.string "line1", null: false
    t.string "line2"
    t.string "line3"
    t.string "postal_code", null: false
    t.string "state"
    t.string "country", null: false
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "bank_accounts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "sort_code", null: false
    t.string "account_number", null: false
    t.string "iban", null: false
    t.string "bic", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_bank_accounts_on_company_id"
  end

  create_table "clients", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "contact", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_clients_on_company_id"
  end

  create_table "companies", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "vat_number", null: false
    t.string "number", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "currencies", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.integer "display_decimals", default: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_entries", charset: "utf8mb3", force: :cascade do |t|
    t.string "description", null: false
    t.float "amount", default: 0.0, null: false
    t.float "claim_percentage", default: 0.0, null: false
    t.bigint "currency_id", null: false
    t.bigint "period_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_expense_entries_on_currency_id"
    t.index ["period_id"], name: "index_expense_entries_on_period_id"
  end

  create_table "invoice_entries", charset: "utf8mb3", force: :cascade do |t|
    t.string "description", null: false
    t.float "amount", default: 0.0, null: false
    t.float "rate", default: 0.0, null: false
    t.float "vat", default: 0.0, null: false
    t.bigint "currency_id", null: false
    t.bigint "period_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_invoice_entries_on_currency_id"
    t.index ["period_id"], name: "index_invoice_entries_on_period_id"
  end

  create_table "periods", charset: "utf8mb3", force: :cascade do |t|
    t.date "due", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.integer "number", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_periods_on_client_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bank_accounts", "companies"
  add_foreign_key "clients", "companies"
  add_foreign_key "companies", "users"
  add_foreign_key "expense_entries", "currencies"
  add_foreign_key "expense_entries", "periods"
  add_foreign_key "invoice_entries", "currencies"
  add_foreign_key "invoice_entries", "periods"
  add_foreign_key "periods", "clients"
end
