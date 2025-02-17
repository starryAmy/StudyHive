class CreateSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :spots do |t|
      t.references :desk, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
