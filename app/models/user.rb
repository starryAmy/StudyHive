class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :desk, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :rooms, dependent: :destroy
end
