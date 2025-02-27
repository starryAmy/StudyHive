class Room < ApplicationRecord
  belongs_to :user
  has_many :spots, dependent: :destroy
  has_many :chatmessages, dependent: :destroy
  has_many :polls, dependent: :destroy
end
