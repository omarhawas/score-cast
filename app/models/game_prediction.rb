class GamePrediction < ApplicationRecord
  belongs_to :game
  belongs_to :league_user
end
