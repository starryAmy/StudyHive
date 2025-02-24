class RemoveDeskForeignKeyFromNotepads < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :notepads, :desks
  end
end
