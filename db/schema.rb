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

ActiveRecord::Schema.define(version: 20150910115848) do

  create_table "first_price_joiners", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "nickname"
    t.string   "heading_url"
    t.string   "openid"
    t.integer  "point"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
  end

  add_index "first_price_joiners", ["openid"], name: "index_first_price_joiners_on_openid", unique: true
  add_index "first_price_joiners", ["point"], name: "index_first_price_joiners_on_point"
  add_index "first_price_joiners", ["updated_at"], name: "index_first_price_joiners_on_updated_at"

  create_table "first_price_voters", force: :cascade do |t|
    t.string   "nickname"
    t.string   "heading_url"
    t.string   "openid"
    t.integer  "first_price_joiner_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "first_price_voters", ["first_price_joiner_id", "openid"], name: "index_first_price_voters_on_first_price_joiner_id_and_openid", unique: true
  add_index "first_price_voters", ["first_price_joiner_id"], name: "index_first_price_voters_on_first_price_joiner_id"

  create_table "test_requesters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_responders", force: :cascade do |t|
    t.string   "name"
    t.integer  "test_requester_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "test_responders", ["test_requester_id"], name: "index_test_responders_on_test_requester_id"

end
