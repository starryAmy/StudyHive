class AddInterestAndQuestionToDesks < ActiveRecord::Migration[7.1]
  def change
    add_column :desks, :interest, :string
    add_column :desks, :question, :string
  end
end
