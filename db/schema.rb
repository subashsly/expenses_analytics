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

ActiveRecord::Schema.define(version: 20171026053600) do

  create_table "categories", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.text     "type"
    t.integer  "member_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories", ["member_id"], name: "index_categories_on_member_id"

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_no"
    t.string   "address"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacts", ["member_id"], name: "index_contacts_on_member_id"

  create_table "expenses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "amount"
    t.date     "date"
    t.integer  "member_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "expenses", ["member_id"], name: "index_expenses_on_member_id"

  create_table "incomes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "amount"
    t.date     "date"
    t.integer  "member_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "incomes", ["category_id"], name: "index_incomes_on_category_id"
  add_index "incomes", ["member_id", "created_at"], name: "index_incomes_on_member_id_and_created_at"
  add_index "incomes", ["member_id"], name: "index_incomes_on_member_id"

  create_table "members", force: :cascade do |t|
    t.string   "member_name"
    t.string   "member_email"
    t.string   "member_country"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.datetime "agreed_to_terms"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "members", ["member_email"], name: "index_members_on_member_email", unique: true

  create_table "reminders", force: :cascade do |t|
    t.text     "title"
    t.date     "date_notify"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "amount"
    t.text     "description"
    t.integer  "member_id"
  end

  add_index "reminders", ["member_id"], name: "index_reminders_on_member_id"

end
