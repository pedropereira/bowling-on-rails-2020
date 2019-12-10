class CreateRolls < ActiveRecord::Migration[6.0]
  def change
    create_table :rolls do |t|
      t.integer :pins
      t.timestamps null: false

      t.references :frame, index: true, foreign_key: { on_delete: :cascade }
    end
  end
end
