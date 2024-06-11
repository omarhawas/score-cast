class Tournament < ApplicationRecord
    has_many :leagues

    validates :name, :start_date, :end_date, :status, presence: true

    STATUS = %w(Active Inactive)

end
