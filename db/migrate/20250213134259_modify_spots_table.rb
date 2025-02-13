class ModifySpotsTable < ActiveRecord::Migration[7.1]
  def change
    remove_reference :spots, :desk, foreign_key: true
    add_reference :spots, :user, foreign_key: true
  end
end
