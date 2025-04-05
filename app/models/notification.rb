class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :room
  after_create_commit :broadcast_to_hiveboard

  private

  def broadcast_to_hiveboard
    broadcast_append_to(
      # users have to subsribe to the room channel to receive notifications
      # this is done at the top of hiveboard for each room by using turbo_stream
      "hiveboard_#{room.id}",
      target: "hiveboard_#{room.id}",
      partial: "shared/tabs/notification",
      locals: { notification: self }
    )
  end
end
