class Post < ApplicationRecord
  belongs_to :store, optional: true
  has_many :favorites, dependent: :destroy
  mount_uploader :product_img, ProductImgUploader

  validates :product_img, file_content_type: { allow: /^image\/.*/ }
  validates :product_introduction, presence: true

  def store
    return Store.find_by(id: self.store_id)
  end

  def favorite?(user)
    favorites.where(user_id: user.id).exists?
  end

end
