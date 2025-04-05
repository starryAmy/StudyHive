class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :title
      t.references :desk, null: false, foreign_key: true

      t.timestamps
    end
  end
end
