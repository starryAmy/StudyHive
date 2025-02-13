class Desk < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :messages, dependent: :destroy
end
