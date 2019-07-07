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

ActiveRecord::Schema.define(version: 2019_07_07_065424) do

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "picture"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.string "comment"
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "star"
    t.index ["book_id", "user_id"], name: "index_evaluations_on_book_id_and_user_id", unique: true
    t.index ["book_id"], name: "index_evaluations_on_book_id"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_favorites_on_book_id"
    t.index ["user_id", "book_id"], name: "index_favorites_on_user_id_and_book_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "picture"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "volume_id"
    t.index ["volume_id"], name: "index_pictures_on_volume_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "uid"
    t.string "oauth_token"
    t.string "oauth_expires_at"
  end

  create_table "volumes", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "book_id"
    t.index ["book_id"], name: "index_volumes_on_book_id"
  end

end
