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

ActiveRecord::Schema.define(:version => 20130424140607) do

  create_table "approvals", :force => true do |t|
    t.integer  "borrow_request_id"
    t.integer  "user_id"
    t.string   "status",            :default => "pending"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "approvals", ["borrow_request_id"], :name => "index_approvals_on_borrow_request_id"
  add_index "approvals", ["status"], :name => "index_approvals_on_status"
  add_index "approvals", ["user_id"], :name => "index_approvals_on_user_id"

  create_table "borrow_requests", :force => true do |t|
    t.integer  "thing_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "borrow_requests", ["created_at"], :name => "index_borrow_requests_on_created_at"
  add_index "borrow_requests", ["thing_id"], :name => "index_borrow_requests_on_thing_id"
  add_index "borrow_requests", ["user_id"], :name => "index_borrow_requests_on_user_id"

  create_table "friendships", :force => true do |t|
    t.integer "friendable_id"
    t.integer "friend_id"
    t.integer "blocker_id"
    t.boolean "pending",       :default => true
  end

  add_index "friendships", ["friendable_id", "friend_id"], :name => "index_friendships_on_friendable_id_and_friend_id", :unique => true

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
    t.integer  "held_by"
  end

  create_table "transfers", :force => true do |t|
    t.datetime "datetime"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.integer  "thing_id"
    t.integer  "borrow_request_id"
  end

  add_index "transfers", ["borrow_request_id"], :name => "index_transfers_on_borrow_request_id"
  add_index "transfers", ["datetime"], :name => "index_transfers_on_datetime"
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
