class User < ApplicationRecord
  acts_as_favoritor
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:line]

  has_one :desk, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :rooms, dependent: :destroy

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize
    user.email = auth.info.email if auth.info.email.present?
    user.password = Devise.friendly_token[0, 20] if user.new_record?
    user.username = auth.info.name if user.new_record?
    user.save
    user
  end

# when user finished signing up, the desk will auto be created
  after_create :create_desk

  private

  def create_desk
    Desk.create(user: self, points: 0, title: "#{self.username}'s Desk")
  end
end
