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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141201225522) do

  create_table "categories", force: true do |t|
    t.string "name"
  end

  create_table "follower_relations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "followee_id"
  end

  create_table "invitations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "token"
    t.string   "new_user_email"
    t.string   "new_user_name"
  end

  create_table "queued_videos", force: true do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "queue_position"
  end

  create_table "reviews", force: true do |t|
    t.text     "review"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "video_id"
  end

  create_table "users", force: true do |t|
    t.string  "username"
    t.string  "email"
    t.string  "password_digest"
    t.string  "token"
    t.boolean "admin"
  end

  create_table "video_categories", force: true do |t|
    t.integer "video_id"
    t.integer "category_id"
  end

  create_table "videos", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "large_cover"
    t.string   "small_cover"
    t.string   "video_url"
  end

end
