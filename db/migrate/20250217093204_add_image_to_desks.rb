class AddImageToDesks < ActiveRecord::Migration[7.1]
  def change
    add_column :desks, :image, :string
  end
end
