class Post < ApplicationRecord
  belongs_to :store, optional: true
  mount_uploader :product_img, ProductImgUploader

  validates :product_img, file_content_type: { allow: /^image\/.*/ }
  validates :product_introduction, presence: true

end
