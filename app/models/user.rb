class User < ApplicationRecord
    has_secure_password
    has_many :league_users
    has_many :leagues, through: :league_users

    has_many :admin_leagues, class_name: 'League', foreign_key: 'admin_user_id'
    has_many :winner_leagues, class_name: 'League', foreign_key: 'winner_user_id'
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
