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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130409100119) do

  create_table "stakes", :force => true do |t|
    t.decimal  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "thing_id"
  end

  add_index "stakes", ["thing_id"], :name => "index_stakes_on_thing_id"
  add_index "stakes", ["user_id"], :name => "index_stakes_on_user_id"

  create_table "things", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transfers", :force => true do |t|
    t.datetime "datetime"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.integer  "thing_id"
  end

  add_index "transfers", ["from_user_id"], :name => "index_transfers_on_from_user_id"
  add_index "transfers", ["thing_id"], :name => "index_transfers_on_thing_id"
  add_index "transfers", ["to_user_id"], :name => "index_transfers_on_to_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
