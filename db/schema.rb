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

ActiveRecord::Schema.define(version: 2020_03_15_141705) do

  create_table "foods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "category"
    t.integer "price_id"
    t.string "tag"
    t.string "name"
    t.float "calorie"
    t.float "water"
    t.float "protain"
    t.float "lipid"
    t.float "carbohydrate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "twenty_nineteen_feb"
    t.integer "twenty_nineteen_mar"
    t.integer "twenty_nineteen_apr"
    t.integer "twenty_nineteen_may"
    t.integer "twenty_nineteen_jun"
    t.integer "twenty_nineteen_jul"
    t.integer "twenty_nineteen_aug"
    t.integer "twenty_nineteen_sep"
    t.integer "twenty_nineteen_oct"
    t.integer "twenty_nineteen_nov"
    t.integer "twenty_nineteen_dec"
    t.integer "twenty_twenty_jan"
    t.integer "twenty_twenty_feb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
