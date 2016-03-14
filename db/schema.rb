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

ActiveRecord::Schema.define(version: 20160314145913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "food_items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.string   "section"
    t.string   "image_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "view"
    t.string   "cuisine"
    t.decimal  "star_avg"
  end

  create_table "order_lists", force: :cascade do |t|
    t.string   "list"
    t.integer  "user_order_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "coupon_code"
  end

  add_index "order_lists", ["user_order_id"], name: "index_order_lists_on_user_order_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "star"
    t.text     "text"
    t.integer  "food_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "reviews", ["food_item_id"], name: "index_reviews_on_food_item_id", using: :btree

  create_table "user_orders", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_lists", "user_orders"
  add_foreign_key "reviews", "food_items"
end
