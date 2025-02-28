class RemoveInterestAndQuestionFromRooms < ActiveRecord::Migration[7.1]
  def change
    remove_column :rooms, :interest, :string
    remove_column :rooms, :question, :string
  end
end
