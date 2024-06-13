class League < ApplicationRecord
  belongs_to :admin_user, class_name: 'User'
  belongs_to :winner_user, class_name: 'User', optional: true
  belongs_to :tournament
  
  validates :name, presence: true
  validates :tournament_id, presence: true
end
