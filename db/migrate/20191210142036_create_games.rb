class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :state, default: :ongoing, null: false
      t.timestamps null: false
    end
  end
end
