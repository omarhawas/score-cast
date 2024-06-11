class LeagueUser < ApplicationRecord
  belongs_to :user
  belongs_to :league
  has_many :predictions
end
