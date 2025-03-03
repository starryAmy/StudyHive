class Room < ApplicationRecord
  belongs_to :user
  has_many :spots, dependent: :destroy
  has_many :chatmessages, dependent: :destroy
  has_many :polls, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :invites, dependent: :destroy

  after_create :create_spot_for_owner
  # after_commit :broadcast_message

  private

  def create_spot_for_owner
    spots.create(user: user, status: :accepted)
  end

  def broadcast_message
    broadcast_append_to "room_#{room.id}_resources",
                        partial: "shared/resources"
  end
end
