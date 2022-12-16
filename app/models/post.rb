class Post < ApplicationRecord
  belongs_to :store, optional: true
  mount_uploader :product_img, ProductImgUploader
end
