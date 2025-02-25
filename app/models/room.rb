class Room < ApplicationRecord
  belongs_to :user
  has_many :spots, dependent: :destroy
  has_many :chatmessages, dependent: :destroy

  after_create :create_spot_for_owner

  private

  def create_spot_for_owner
    spots.create(user: user, status: :accepted)
  end
end
