require 'rails_helper'

RSpec.describe Post, type: :model do
  #バリデーションのテスト
  describe "validates test" do
    #写真、投稿説明文があれば有効な状態であること
    it "is valid with a product_img, product_introduction" do
      store = create(:store)

    end
    #写真がなければ無効な状態であること
    #投稿説明文がなければ無効な状態であること
  end

end
