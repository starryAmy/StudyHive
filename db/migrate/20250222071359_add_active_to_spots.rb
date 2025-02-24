class AddActiveToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :active, :boolean, default: false
  end
end
