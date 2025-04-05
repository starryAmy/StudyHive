class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.boolean :public
      t.boolean :locked

      t.timestamps
    end
  end
end
