class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :admin_user_id, null: false
      t.integer :winner_user_id, null: false
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
