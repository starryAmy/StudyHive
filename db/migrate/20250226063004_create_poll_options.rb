class CreatePollOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :poll_options do |t|
      t.string :option_text
      t.references :poll, null: false, foreign_key: true
      t.timestamps
    end
  end
end
