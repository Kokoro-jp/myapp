class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i

  validates :user_name, presence: true
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX }, if: :password_required?

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  def favorited_by?(post_id)
    favorites.where(post_id:).exists?
  end

  USER_EMAIL = 'guest@example.com'.freeze
  def self.guest
    find_or_create_by!(email: USER_EMAIL) do |user|
      user.id = '0'
      user.password = SecureRandom.alphanumeric(6)
      user.user_name = 'ゲスト'
    end
  end
end
