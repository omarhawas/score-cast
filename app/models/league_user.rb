class LeagueUser < ApplicationRecord
  belongs_to :user
  belongs_to :league
  has_many :game_predictions


  def get_game_predictions
    total = 0
    self.game_predictions.each do |game_prediction|
      total = total + (game_prediction.total_points || 0)
    end
    
    total
  end
end
