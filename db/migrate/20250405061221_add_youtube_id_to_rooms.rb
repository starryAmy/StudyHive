class AddYoutubeIdToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :youtube_id, :string
  end
end
