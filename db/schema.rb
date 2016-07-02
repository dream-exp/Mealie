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

ActiveRecord::Schema.define(version: 20160515132522) do

  create_table "active_users", force: :cascade do |t|
    t.integer  "student_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "logins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "category"
    t.string   "imageurl"
    t.integer  "cal"
    t.string   "allergy"
    t.integer  "quantity"
    t.text     "description"
    t.boolean  "mon"
    t.boolean  "tue"
    t.boolean  "wed"
    t.boolean  "thu"
    t.boolean  "fri"
    t.integer  "page_view",      default: 0
    t.integer  "purchase_count", default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "student_number"
    t.integer  "menu_id"
    t.string   "menu_name"
    t.integer  "price"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "payments_users", force: :cascade do |t|
    t.integer  "student_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "student_number"
    t.string   "card_id"
    t.integer  "not_pay"
    t.integer  "use_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
