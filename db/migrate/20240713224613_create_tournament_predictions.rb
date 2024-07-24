class CreateTournamentPredictions < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_predictions do |t|
      t.string :winner
      t.string :best_player
      t.string :top_scorer
      t.references :tournament, null: false, foreign_key: true
      t.references :league_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
