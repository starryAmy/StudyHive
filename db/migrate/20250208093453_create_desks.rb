class CreateDesks < ActiveRecord::Migration[7.1]
  def change
    create_table :desks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.integer :points
      t.string :task
      t.timestamps
    end
  end
end
