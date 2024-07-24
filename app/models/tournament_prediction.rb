class TournamentPrediction < ApplicationRecord
  belongs_to :tournament
  belongs_to :league_user
end
