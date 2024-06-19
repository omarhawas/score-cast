class League < ApplicationRecord
  belongs_to :admin_user, class_name: 'User'
  belongs_to :winner_user, class_name: 'User', optional: true
  belongs_to :tournament
  has_many :league_users, dependent: :destroy
  has_many :users, through: :league_users 
  
  validates :name, presence: true
  validates :tournament_id, presence: true
end
