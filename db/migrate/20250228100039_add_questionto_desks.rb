class AddQuestiontoDesks < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :interest, :string
    add_column :rooms, :question, :string
  end
end
