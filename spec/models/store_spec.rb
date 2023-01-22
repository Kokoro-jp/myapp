require 'rails_helper'

RSpec.describe Store, type: :model do
  #有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:store)).to be_valid
  end

  #バリデーションのテスト
  describe "validates test" do
    #店舗名、メール、パスワード、営業時間、店舗住所があれば有効な状態であること
    it "is valid with a store_name, email, password, business_hours, and store_address" do
      store = Store.new(
        store_name: "test_store",
        email: "test@example.com",
        password: "password",
        business_hours: "9:00 ~ 23:00",
        store_address: "東京都新宿区大久保町3丁目offlyerビル2階"
      )
      expect(store).to be_valid
    end
    #店舗名がなければ無効な状態であること
    it "is invalid without a store_name" do
      store = build(:store, store_name: nil)
      store.valid?
      expect(store.errors[:store_name]).to include("が入力されていません。")
    end
    #メールがなければ無効な状態であること
    it "is invalid without a email" do
      store = build(:store, email: nil)
      store.valid?
      expect(store.errors[:email]).to include("が入力されていません。")
    end
    #パスワードが無ければ無効な状態であること
    it "is invalid without a password" do
      store = build(:store, password: nil)
      store.valid?
      expect(store.errors[:password]).to include("が入力されていません。")
    end
    #営業時間が無ければ無効な状態であること
    it "is invalid without a business_hours" do
      store = build(:store, business_hours: nil)
      store.valid?
      expect(store.errors[:business_hours]).to include("が入力されていません。")
    end
    #店舗住所がなければ無効な状態であること
    it "is invalid without a store_address" do
      store = build(:store, store_address: nil)
      store.valid?
      expect(store.errors[:store_address]).to include("が入力されていません。")
    end
    #passwordが無ければ無効な状態であること
    it "is invalid without a password" do
      store = build(:store, password: nil)
      store.valid?
      expect(store.errors[:password]).to include("が入力されていません。")
    end
    #passwordとconfirmが一致していないと無効な状態であること
    it "is invalid password doesn't match password_confirmation" do
      store = build(:store, password: "password", password_confirmation: "123456")
      store.valid?
      expect(store.errors[:password_confirmation]).to include("が内容とあっていません。")
    end
    #passwordが半角英数字のみを使用していても6文字以下なら無効な状態であること
    it "is invalid with password less than 6 characters if password with half-width alphanumeric characters" do
      store = build(:store, password: "123ab")
      store.valid?
      expect(store.errors[:password]).to include("は6文字以上に設定して下さい。")
    end
    #重複したメールアドレスなら無効な状態であること
    it "is invalid with a duplicate email address" do
      store = create(:store, email: "store@example.com")
      store = build(:store, email: "store@example.com")
      store.valid?
      expect(store.errors[:email]).to include("は既に使用されています。")
    end
  end
  #アソシエーションのテスト
  describe "assosiation test" do
    #storeが削除されると、投稿も削除されること
    it "is deleted post if store deleted" do
      store = build(:store)
      store.post << build(:post)
      store.save
      expect{store.destroy}.to change {store.post.count}.by(-1)
    end
  end
end
