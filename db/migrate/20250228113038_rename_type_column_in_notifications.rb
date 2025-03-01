class RenameTypeColumnInNotifications < ActiveRecord::Migration[7.1]
  def change
    rename_column :notifications, :type, :category
  end
end
