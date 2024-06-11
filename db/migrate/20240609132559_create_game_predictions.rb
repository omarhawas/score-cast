class CreateGamePredictions < ActiveRecord::Migration[7.0]
  def change
    create_table :game_predictions do |t|
      t.references :game, null: false, foreign_key: true
      t.references :league_user, null: false, foreign_key: true
      t.integer :home_team_goals
      t.integer :away_team_goals
      t.integer :home_team_et_goals
      t.integer :away_team_et_goals
      t.string :penalties_winner
      t.integer :total_points

      t.timestamps
    end
  end
end
