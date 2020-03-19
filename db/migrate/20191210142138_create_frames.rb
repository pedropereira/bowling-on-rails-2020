class CreateFrames < ActiveRecord::Migration[6.0]
  def change
    create_table :frames do |t|
      t.timestamps null: false

      t.references :game, index: true, foreign_key: { on_delete: :cascade }
    end
  end
end
