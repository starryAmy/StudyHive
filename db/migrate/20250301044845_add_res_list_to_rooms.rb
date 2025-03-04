class AddResListToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :res_list, :string, array: true, default: []
  end
end
