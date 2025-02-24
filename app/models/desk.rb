class Desk < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :messages, dependent: :destroy

  before_create :set_default_image
  acts_as_favoritable

  private

  def set_default_image
    # if image is null, then set to desk1 image
    self.image ||= "desk2 - Copy.png"
  end
end
