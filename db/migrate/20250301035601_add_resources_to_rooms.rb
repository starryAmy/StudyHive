class AddResourcesToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :resources_content, :text
  end
end
