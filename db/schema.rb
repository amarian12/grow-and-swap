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

ActiveRecord::Schema.define(version: 20170121214621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garden_items", force: :cascade do |t|
    t.integer  "quantity",        default: 0,  null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "produce_item_id",              null: false
    t.string   "photo",           default: "", null: false
  end

  add_index "garden_items", ["produce_item_id"], name: "index_garden_items_on_produce_item_id", using: :btree
  add_index "garden_items", ["user_id"], name: "index_garden_items_on_user_id", using: :btree

  create_table "produce_items", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "category",   default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "photo",      default: "", null: false
  end

  create_table "trade_offers", force: :cascade do |t|
    t.integer  "quantity",                  default: 1,     null: false
    t.boolean  "accepted",                  default: false, null: false
    t.integer  "user_id",                                   null: false
    t.integer  "garden_item_id",                            null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "reciprocal_trade_offer_id"
  end

  add_index "trade_offers", ["garden_item_id"], name: "index_trade_offers_on_garden_item_id", using: :btree
  add_index "trade_offers", ["reciprocal_trade_offer_id"], name: "index_trade_offers_on_reciprocal_trade_offer_id", using: :btree
  add_index "trade_offers", ["user_id"], name: "index_trade_offers_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      default: "",    null: false
    t.string   "last_name",       default: "",    null: false
    t.string   "email",           default: "",    null: false
    t.string   "password_digest", default: "",    null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "avatar",          default: "",    null: false
    t.string   "street",          default: "",    null: false
    t.string   "city",            default: "",    null: false
    t.string   "state",           default: "",    null: false
    t.string   "zip_code",        default: "",    null: false
    t.float    "latitude",        default: 0.0,   null: false
    t.float    "longitude",       default: 0.0,   null: false
    t.string   "country",         default: "",    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "garden_items", "produce_items"
  add_foreign_key "garden_items", "users"
  add_foreign_key "trade_offers", "garden_items"
  add_foreign_key "trade_offers", "users"
end
