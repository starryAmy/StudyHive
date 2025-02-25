class AddTaskToDesks < ActiveRecord::Migration[7.1]
  def change
    add_column :desks, :task, :string
  end
end
