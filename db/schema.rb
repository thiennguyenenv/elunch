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

ActiveRecord::Schema.define(version: 20150623032055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "categories", force: true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "dishes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "rating"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "token"
  end

  create_table "floors", force: true do |t|
    t.string  "name"
    t.integer "total"
  end

  create_table "meals", force: true do |t|
    t.datetime "meal_date"
    t.integer  "preordered_meals"
    t.integer  "actual_meals"
    t.integer  "extra_meals"
    t.integer  "absence_with_notice"
  end

  create_table "pictures", force: true do |t|
    t.string   "image"
    t.string   "description"
    t.integer  "meal_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "meal_token"
  end

  create_table "shifts", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tables", force: true do |t|
    t.integer  "seats"
    t.integer  "shift_id"
    t.integer  "available_seats"
    t.hstore   "cached_users"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "name"
    t.text     "description"
    t.text     "cached_seats"
    t.boolean  "for_vegans",      default: false
  end

  create_table "tables_users", id: false, force: true do |t|
    t.integer "table_id"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "floor_id"
    t.string   "what_your_taste"
    t.boolean  "admin",                            default: false
    t.boolean  "want_vegan_meal",                  default: false
    t.integer  "progress_status",        limit: 2, default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
