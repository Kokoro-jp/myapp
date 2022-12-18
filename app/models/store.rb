class Store < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i

  validates :store_name, presence: true
  validates :store_address, presence: true
  validates :business_hours, presence: true
  validates :password, presence: true, format: {with: VALID_PASSWORD_REGEX }

  def posts
    return Post.where(store_id: self.id)
  end

end
