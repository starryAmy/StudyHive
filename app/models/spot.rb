class Spot < ApplicationRecord
  belongs_to :desk
  belongs_to :room
end
