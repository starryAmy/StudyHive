class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.datetime :date
      t.string :text
      t.references :user, null: false, foreign_key: true
      t.references :desk, null: false, foreign_key: true

      t.timestamps
    end
  end
end
