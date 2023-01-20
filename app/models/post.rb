class Post < ApplicationRecord
  belongs_to :store, optional: true
  has_many :favorites, dependent: :destroy
  mount_uploader :product_img, ProductImgUploader
  is_impressionable counter_cache: true

  validates :product_img, presence: true
  validates :product_introduction, presence: true


  #新規投稿後、store_idを取得する
  def store
    return Store.find_by(id: self.store_id)
  end

  #favoriteテーブルにuser_idが存在しているか
  def favorite?(user)
    favorites.where(user_id: user.id).exists?
  end

end
