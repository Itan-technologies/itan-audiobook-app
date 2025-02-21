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

ActiveRecord::Schema[7.1].define(version: 2025_02_21_124338) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "audiobooks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "ebook_id", null: false
    t.string "audio_file_url"
    t.integer "duration"
    t.boolean "status"
    t.string "unique_audio_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ebook_id"], name: "index_audiobooks_on_ebook_id"
    t.index ["title"], name: "index_audiobooks_on_title"
  end

  create_table "chapters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "audiobook_id", null: false
    t.uuid "ebook_id", null: false
    t.string "title"
    t.string "audio_file_url"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audiobook_id"], name: "index_chapters_on_audiobook_id"
    t.index ["ebook_id"], name: "index_chapters_on_ebook_id"
  end

  create_table "ebooks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "edition_number"
    t.string "contributors"
    t.integer "primary_audience"
    t.boolean "publishing_rights"
    t.string "file_url"
    t.string "cover_image_url"
    t.integer "status"
    t.integer "price"
    t.string "unique_ebook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["primary_audience"], name: "index_ebooks_on_primary_audience"
    t.index ["title"], name: "index_ebooks_on_title"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "purchases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "audiobook_id", null: false
    t.uuid "user_id", null: false
    t.integer "amount"
    t.string "purchase_status"
    t.datetime "purchase_date"
    t.string "paystack_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "ebook_id"
    t.index ["audiobook_id"], name: "index_purchases_on_audiobook_id"
    t.index ["ebook_id"], name: "index_purchases_on_ebook_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "audiobook_id", null: false
    t.uuid "ebook_id", null: false
    t.integer "rating"
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audiobook_id"], name: "index_reviews_on_audiobook_id"
    t.index ["ebook_id"], name: "index_reviews_on_ebook_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_audiobooks", id: false, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "audiobook_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audiobook_id"], name: "index_users_audiobooks_on_audiobook_id"
    t.index ["user_id", "audiobook_id"], name: "index_users_audiobooks_on_user_id_and_audiobook_id", unique: true
    t.index ["user_id"], name: "index_users_audiobooks_on_user_id"
  end

  create_table "users_ebooks", id: false, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "ebook_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ebook_id"], name: "index_users_ebooks_on_ebook_id"
    t.index ["user_id", "ebook_id"], name: "index_users_ebooks_on_user_id_and_ebook_id", unique: true
    t.index ["user_id"], name: "index_users_ebooks_on_user_id"
  end

  add_foreign_key "audiobooks", "ebooks"
  add_foreign_key "chapters", "audiobooks"
  add_foreign_key "chapters", "ebooks"
  add_foreign_key "notifications", "users"
  add_foreign_key "purchases", "audiobooks"
  add_foreign_key "purchases", "ebooks"
  add_foreign_key "purchases", "users"
  add_foreign_key "reviews", "audiobooks"
  add_foreign_key "reviews", "ebooks"
  add_foreign_key "reviews", "users"
  add_foreign_key "users_audiobooks", "audiobooks"
  add_foreign_key "users_audiobooks", "users"
  add_foreign_key "users_ebooks", "ebooks"
  add_foreign_key "users_ebooks", "users"
end
