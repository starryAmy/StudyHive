class AddIntroToDesks < ActiveRecord::Migration[7.1]
  def change
    add_column :desks, :intro, :text
  end
end
