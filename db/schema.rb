# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_18_075029) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "izakaya_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["izakaya_id"], name: "index_favorites_on_izakaya_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "izakaya_plans", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "izakaya_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["izakaya_id"], name: "index_izakaya_plans_on_izakaya_id"
    t.index ["plan_id"], name: "index_izakaya_plans_on_plan_id"
  end

  create_table "izakaya_tags", force: :cascade do |t|
    t.bigint "izakaya_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["izakaya_id"], name: "index_izakaya_tags_on_izakaya_id"
    t.index ["tag_id"], name: "index_izakaya_tags_on_tag_id"
  end

  create_table "izakayas", force: :cascade do |t|
    t.string "name"
    t.string "formatted_address"
    t.float "lat"
    t.float "lng"
    t.string "photo_reference"
    t.string "image"
    t.string "opening_hours"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "url"
  end

  create_table "plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.boolean "public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "favorites", "izakayas"
  add_foreign_key "favorites", "users"
  add_foreign_key "izakaya_plans", "izakayas"
  add_foreign_key "izakaya_plans", "plans"
  add_foreign_key "izakaya_tags", "izakayas"
  add_foreign_key "izakaya_tags", "tags"
  add_foreign_key "plans", "users"
end
