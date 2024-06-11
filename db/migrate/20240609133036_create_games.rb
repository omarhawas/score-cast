class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :tournament, null: false, foreign_key: true
      t.string :home_team
      t.string :away_team
      t.integer :home_team_goals
      t.integer :away_team_goals
      t.integer :home_team_et_goals
      t.integer :away_team_et_goals
      t.string :penalties_winner
      t.datetime :game_start
      t.datetime :game_end
      t.boolean :knockout_game

      t.timestamps
    end
  end
end
