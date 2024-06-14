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

ActiveRecord::Schema[7.0].define(version: 2024_06_09_140853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_predictions", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "league_user_id", null: false
    t.integer "home_team_goals"
    t.integer "away_team_goals"
    t.integer "home_team_et_goals"
    t.integer "away_team_et_goals"
    t.string "penalties_winner"
    t.integer "total_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_predictions_on_game_id"
    t.index ["league_user_id"], name: "index_game_predictions_on_league_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.string "home_team"
    t.string "away_team"
    t.integer "home_team_goals"
    t.integer "away_team_goals"
    t.integer "home_team_et_goals"
    t.integer "away_team_et_goals"
    t.string "penalties_winner"
    t.datetime "game_start"
    t.datetime "game_end"
    t.boolean "knockout_game"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_games_on_tournament_id"
  end

  create_table "league_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "league_id", null: false
    t.string "username"
    t.integer "total_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_users_on_league_id"
    t.index ["user_id"], name: "index_league_users_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.integer "admin_user_id", null: false
    t.integer "winner_user_id", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_leagues_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "game_predictions", "games"
  add_foreign_key "game_predictions", "league_users"
  add_foreign_key "games", "tournaments"
  add_foreign_key "league_users", "leagues"
  add_foreign_key "league_users", "users"
  add_foreign_key "leagues", "tournaments"
end
