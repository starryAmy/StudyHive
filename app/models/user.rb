class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :desk, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :rooms, dependent: :destroy

# when user finished signing up, the desk will auto be created
  after_create :create_desk

  private

  def create_desk
    Desk.create(user: self, points: 0, title: "#{self.username}'s Desk")
  end
end
