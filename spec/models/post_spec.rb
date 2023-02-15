require 'rails_helper'

RSpec.describe Post, type: :model do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:post)).to be_valid
  end

  # バリデーションのテスト
  describe 'validates test' do
    before :each do
      @store = create(:store)
      @post = build(:post, store_id: @store.id)
    end
    # 写真、投稿説明文があれば有効な状態であること
    it 'is valid with a product_img, product_introduction' do
      expect(@post).to be_valid
    end
    # 写真がなければ無効な状態であること
    it 'is invalid without a product_img' do
      @post.product_img = nil
      @post.valid?
      expect(@post.errors[:product_img]).to include('が選択されていません。')
    end
    # 投稿説明文がなければ無効な状態であること
    it 'is invalid without a product_introduction' do
      @post.product_introduction = nil
      @post.valid?
      expect(@post.errors[:product_introduction]).to include('が入力されていません。')
    end
  end
  describe 'assosiation' do
    # storeを削除すると、storeが書いたpostも削除されること
    it 'is deleted when delete store' do
      store = create(:store)
      create(:post, store_id: store.id)
      expect { store.destroy }.to change { Post.count }.by(-1)
    end
    # お気に入りされた投稿にuser_idが紐づいていること
    it 'is associated with user_id' do
      user = create(:user)
      post = create(:post)
      create(:favorite, user_id: user.id, post_id: post.id)
      expect(post.favorite?(user)).to be_truthy
    end
  end
end
