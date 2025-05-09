class CreateChatmessages < ActiveRecord::Migration[7.1]
  def change
    create_table :chatmessages do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
