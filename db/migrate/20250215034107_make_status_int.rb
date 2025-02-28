class MakeStatusInt < ActiveRecord::Migration[7.1]
  def change
    remove_column :spots, :status, :string
    add_column :spots, :status, :integer, default: 0
  end
end
