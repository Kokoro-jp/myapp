class Store < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  is_impressionable counter_cache: true

  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i

  validates :store_name, presence: true
  validates :store_address, presence: true
  validates :business_hours, presence: true
  validates :password, presence: true, format: {with: VALID_PASSWORD_REGEX }, if: :password_required?

  def posts
    return Post.where(store_id: self.id)
  end

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

  geocoded_by :store_address
  after_validation :geocode, if: :store_address_changed?

  STORE_EMAIL = 'store_guest@example.com'

  def self.guest
    find_or_create_by!(email: STORE_EMAIL) do |store|
      store.id = "0"
      store.password = SecureRandom.alphanumeric(6)
      store.store_name = "ゲスト(店舗)"
      store.business_hours = "9:00 ~ 22:00"
      store.store_address = "東京都千代田区1丁目Offlyerタワー1階"
    end
  end
end
