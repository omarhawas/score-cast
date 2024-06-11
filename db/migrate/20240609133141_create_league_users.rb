class CreateLeagueUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :league_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true
      t.string :username
      t.integer :total_points

      t.timestamps
    end
  end
end
