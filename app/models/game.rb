class Game < ApplicationRecord
  belongs_to :tournament
  has_many :game_predictions
end
