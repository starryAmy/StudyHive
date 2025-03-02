class RemoveResourcesContentFromRooms < ActiveRecord::Migration[7.1]
  def change
    remove_column :rooms, :resources_content, :text
  end
end
