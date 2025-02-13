class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :room
  enum status: [ :pending, :rejected, :accepted ]
end
