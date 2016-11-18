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

ActiveRecord::Schema.define(version: 20161118130001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "properties", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.integer  "price"
    t.integer  "size"
    t.integer  "num_bedrooms"
    t.integer  "num_bathrooms"
    t.string   "property_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "lat"
    t.float    "lon"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",                      null: false
    t.string   "uid",                           null: false
    t.string   "first_name"
    t.string   "image_url"
    t.string   "url"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "last_name"
    t.string   "gender"
    t.string   "age_range"
    t.boolean  "is_landlord",   default: false
    t.boolean  "is_renter",     default: false
    t.string   "phone_number"
    t.string   "personal_info", default: ""
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
    t.index ["provider"], name: "index_users_on_provider", using: :btree
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

end
