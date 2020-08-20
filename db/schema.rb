# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_20_132202) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "species"
    t.string "character_type"
    t.string "gender"
    t.string "image"
    t.time "created", default: "2000-01-01 16:44:52"
    t.integer "location_id"
    t.integer "origin_id"
  end

  create_table "characters_episodes", force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "episode_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_characters_episodes_on_character_id"
    t.index ["episode_id"], name: "index_characters_episodes_on_episode_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "name"
    t.time "air_date"
    t.string "episode"
    t.string "url"
    t.time "created", default: "2000-01-01 16:44:52"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "location_type"
    t.string "dimension"
    t.string "url"
    t.time "created", default: "2000-01-01 17:13:10"
  end

  add_foreign_key "characters_episodes", "characters"
  add_foreign_key "characters_episodes", "episodes"
end
