class Store < ApplicationRecord

  validates :store_name, presence: true
  validates :store_address, presence: true, uniqueness: true
  validates :business_hours, presence: true
  validates :email, uniqueness: true, length: { maximum: 50 }
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
