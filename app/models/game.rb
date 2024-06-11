class Game < ApplicationRecord
  belongs_to :tournament
  has_many :predictions
end
