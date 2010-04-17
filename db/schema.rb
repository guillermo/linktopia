# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100417153432) do

  create_table "deputies", :force => true do |t|
    t.string   "name"
    t.string   "photo_url"
    t.integer  "parliamentary_group_id"
    t.integer  "political_party_id"
    t.string   "email"
    t.string   "url"
    t.integer  "initiatives_count"
    t.integer  "speeches_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deputies_initiatives", :force => true do |t|
    t.integer "initiative_id"
    t.integer "deputy_id"
  end

  create_table "initiatives", :force => true do |t|
    t.string   "body"
    t.string   "kind"
    t.string   "subkind"
    t.datetime "submitted_at"
    t.datetime "described_at"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parliamentary_groups", :force => true do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "political_parties", :force => true do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
