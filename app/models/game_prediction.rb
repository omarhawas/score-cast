class GamePrediction < ApplicationRecord
  belongs_to :game
  belongs_to :league_user

  has_one :user, through: :league_user
  has_one :league, through: :league_user

  validates :home_team_goals, presence: true
  validates :away_team_goals, presence: true

end
