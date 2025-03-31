class Chatmessage < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :room

  after_create :broadcast_chatmessage

  private

  def broadcast_chatmessage
    broadcast_append_to "room_#{room.id}_chatmessages",
                        partial: "chatmessages/chatmessage",
                        locals: { chatmessage: self, liked: false }
  end
end
