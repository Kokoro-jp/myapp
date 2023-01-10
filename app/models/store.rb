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

end
