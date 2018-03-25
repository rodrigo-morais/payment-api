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

ActiveRecord::Schema.define(version: 20180325152851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "organisations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "version"
    t.uuid "organisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "CREATED"
    t.float "amount"
    t.string "currency"
    t.string "beneficiary_name"
    t.string "beneficiary_account_number"
    t.string "beneficiary_account_number_code"
    t.string "beneficiary_bank_id"
    t.string "beneficiary_bank_id_code"
    t.string "debtor_name"
    t.string "debtor_account_number"
    t.string "debtor_account_number_code"
    t.string "debtor_bank_id"
    t.string "debtor_bank_id_code"
  end

end
