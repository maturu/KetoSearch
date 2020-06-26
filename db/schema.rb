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

ActiveRecord::Schema.define(version: 2020_06_26_140237) do

  create_table "coupons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.bigint "store_id"
    t.string "signature"
    t.date "expiration_date"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "coupon_color"
    t.boolean "used", default: false, null: false
    t.boolean "confirmed", default: false, null: false
    t.index ["review_id"], name: "index_coupons_on_review_id"
    t.index ["store_id"], name: "index_coupons_on_store_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "foods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tag"
    t.string "name"
    t.integer "gram"
    t.float "calorie"
    t.float "water"
    t.float "protain"
    t.float "lipid"
    t.float "carbohydrate"
    t.float "fibtg"
    t.text "content"
    t.string "reference"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "na"
    t.boolean "egg"
    t.boolean "milk"
    t.boolean "wheat"
    t.boolean "shrimp"
    t.boolean "crab"
    t.boolean "peanut"
    t.boolean "buckwheat"
    t.string "allergies"
    t.boolean "enter_allergies"
    t.bigint "store_id"
    t.integer "browse", default: 0, null: false
    t.integer "price"
    t.boolean "review_permit", default: true, null: false
    t.index ["store_id"], name: "index_foods_on_store_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "visiter_id"
    t.integer "visited_id"
    t.bigint "review_id"
    t.bigint "coupon_id"
    t.string "action"
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "food_id"
    t.index ["coupon_id"], name: "index_notifications_on_coupon_id"
    t.index ["food_id"], name: "index_notifications_on_food_id"
    t.index ["review_id"], name: "index_notifications_on_review_id"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "review_title"
    t.text "review_details"
    t.float "rate", default: 0.0, null: false
    t.bigint "user_id"
    t.bigint "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report", default: 0, null: false
    t.integer "helpful", default: 0, null: false
    t.index ["food_id"], name: "index_reviews_on_food_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "postal_code"
    t.text "description"
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "subscribes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_subscribes_on_store_id"
    t.index ["user_id"], name: "index_subscribes_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "introduction"
    t.string "address"
    t.string "website"
    t.integer "age"
    t.string "job"
    t.boolean "admin", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "coupons", "reviews"
  add_foreign_key "coupons", "stores"
  add_foreign_key "coupons", "users"
  add_foreign_key "foods", "stores"
  add_foreign_key "notifications", "coupons"
  add_foreign_key "notifications", "foods"
  add_foreign_key "notifications", "reviews"
  add_foreign_key "reviews", "foods"
  add_foreign_key "reviews", "users"
  add_foreign_key "stores", "users"
  add_foreign_key "subscribes", "stores"
  add_foreign_key "subscribes", "users"
end
