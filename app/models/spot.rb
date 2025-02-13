class Spot < ApplicationRecord
  belongs_to :desk
  belongs_to :room
  enum status: [ :pending, :rejected, :accepted ]
end
