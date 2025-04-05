class AddYoutubeIdStartTimeToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :youtube_start_time, :string
  end
end
