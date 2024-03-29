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

ActiveRecord::Schema.define(version: 2021_06_07_213336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.date "release_date"
    t.string "description"
    t.decimal "popularity"
    t.decimal "vote_average"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_movies", force: :cascade do |t|
    t.bigint "search_id"
    t.bigint "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_search_movies_on_movie_id"
    t.index ["search_id"], name: "index_search_movies_on_search_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "search_movies", "movies"
  add_foreign_key "search_movies", "searches"
end
