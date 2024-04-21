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

ActiveRecord::Schema[7.1].define(version: 2024_04_21_070127) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "league_id", null: false
    t.uuid "home_ad_player_id", null: false
    t.uuid "home_deuce_player_id", null: false
    t.uuid "away_ad_player_id", null: false
    t.uuid "away_deuce_player_id", null: false
    t.integer "turn", null: false
    t.integer "home_score", null: false
    t.integer "away_score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_ad_player_id"], name: "index_games_on_away_ad_player_id"
    t.index ["away_deuce_player_id"], name: "index_games_on_away_deuce_player_id"
    t.index ["home_ad_player_id"], name: "index_games_on_home_ad_player_id"
    t.index ["home_deuce_player_id"], name: "index_games_on_home_deuce_player_id"
    t.index ["league_id"], name: "index_games_on_league_id"
  end

  create_table "leagues", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "league_id", null: false
    t.string "name", limit: 20, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_players_on_league_id"
  end

  add_foreign_key "games", "leagues"
  add_foreign_key "games", "players", column: "away_ad_player_id"
  add_foreign_key "games", "players", column: "away_deuce_player_id"
  add_foreign_key "games", "players", column: "home_ad_player_id"
  add_foreign_key "games", "players", column: "home_deuce_player_id"
  add_foreign_key "players", "leagues"
end
