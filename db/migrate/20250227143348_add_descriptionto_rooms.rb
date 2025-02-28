class AddDescriptiontoRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :description, :string
  end
end
