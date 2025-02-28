class AddCachedVotesToChatmessages < ActiveRecord::Migration[7.1]
  def change
    add_column :chatmessages, :cached_votes_up, :integer, default: 0
  end
end
