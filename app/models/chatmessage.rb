class Chatmessage < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :broadcast_chatmessage

  private

  def broadcast_chatmessage
    broadcast_append_to "room_#{room.id}_chatmessages",
                        partial: "chatmessages/chatmessage",
                        locals: { chatmessage: self }
  end
end
