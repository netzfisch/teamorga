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

ActiveRecord::Schema.define(:version => 20120916170843) do

  create_table "events", :force => true do |t|
    t.string   "category"
    t.date     "base_date"
    t.time     "base_time"
    t.date     "end_date"
    t.string   "place"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "participations", :force => true do |t|
    t.integer  "recurrence_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "participations", ["recurrence_id"], :name => "index_participations_on_recurrence_id"
  add_index "participations", ["user_id"], :name => "index_participations_on_user_id"

  create_table "recurrences", :force => true do |t|
    t.date     "scheduled_to"
    t.integer  "event_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "recurrences", ["event_id"], :name => "index_recurrences_on_event_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "shirt_number"
    t.string   "email"
    t.string   "phone"
    t.date     "birthday"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

end
