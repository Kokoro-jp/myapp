require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    user = create(:user)
    post = create(:post)
    @favorite = build(:favorite, user_id: user.id, post_id: post.id)
  end

  describe 'favorite function' do
    context 'いいね出来る場合' do
      # user_idとpost_idがあれば保存できること
      it 'is valid with user_id, post_id' do
        expect(@favorite).to be_valid
      end
      # post_idが同じでもuser_idが異なれば、お気に入りできる
      it 'is valid even if post_id is same if user_id is different' do
        another_favorite = create(:favorite)
        expect(create(:favorite, user_id: another_favorite.user_id)).to be_valid
      end
      # user_idが同じでもpost_idが異なれば、お気に入りできる
      it 'is valid even if user_id is same if post_id is different' do
        another_favorite = create(:favorite)
        expect(create(:favorite, post_id: another_favorite.post_id)).to be_valid
      end
    end
    context 'いいね出来ない場合' do
      # user_idがなければ、保存できないこと
      it 'is invalid witout user_id' do
        @favorite.user_id = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include('User が必要です。')
      end
      # post_idがなければ、保存できないこと
      it 'is invalid witout post_id' do
        @favorite.post_id = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include('Post が必要です。')
      end
    end
  end
end
