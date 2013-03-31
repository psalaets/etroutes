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

ActiveRecord::Schema.define(:version => 20130331124314) do

  create_table "routes", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "rid"
    t.string   "grade"
    t.string   "set_by"
    t.string   "gym"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "types"
    t.string   "guid"
  end

  add_index "routes", ["created_at"], :name => "index_routes_on_created_at"
  add_index "routes", ["rid"], :name => "index_routes_on_rid"

end