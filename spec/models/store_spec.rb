require 'rails_helper'

RSpec.describe Store, type: :model do
  #店舗名、メール、パスワード、営業時間、店舗住所があれば有効な状態であること
  it "is valid with a store_name, email, password, business_hours, and store_address" do
    store = Store.new(
      store_name: "test_store",
      email: "test@email.com",
      password: "password",
      business_hours: "9:00 ~ 23:00",
      store_address: "東京都新宿区大久保町3丁目offlyerビル2階"
    )
    expect(store).to be_valid
  end
  #店舗名がなければ無効な状態であること
  it "is invalid without a store_name" do
    store = Store.new(store_name: nil)
    store.valid?
    expect(store.errors[:store_name]).to include("が入力されていません。")
  end
  #メールがなければ無効な状態であること
  it "is invalid withou a email" do
    store = Store.new(email: nil)
    store.valid?
    expect(store.errors[:email]).to include("が入力されていません。")
  end
  #パスワードが無ければ無効な状態であること
  it "is invalid without a password" do
    store = Store.new(password: nil)
    store.valid?
    expect(store.errors[:password]).to include("が入力されていません。")
  end
  #営業時間が無ければ無効な状態であること
  it "is invalid without a business_hours" do
    store = Store.new(business_hours: nil)
    store.valid?
    expect(store.errors[:business_hours]).to include("が入力されていません。")
  end
  #店舗住所がなければ無効な状態であること
  it "is invalid without a store_address" do
    store = Store.new(store_address: nil)
    store.valid?
    expect(store.errors[:store_address]).to include("が入力されていません。")
  end

  #パスワードが無ければ無効な状態であること
  it "is invalid without a password" do
    store = Store.new(password: nil)
    store.valid?
    expect(store.errors[:password]).to include("が入力されていません。")
  end
  #passwordとconfirmが一致していないと無効な状態であること
  it "is invalid password doesn't match password_confirmation" do
    store = Store.new(
      password: "123456",
      password_confirmation: "123454"
    )
    store.valid?
    expect(store.errors[:password_confirmation]).to include("が内容とあっていません。")
  end
  #passwordが半角英数字のみを使用していても6文字以下なら無効な状態であること
  it "is invalid with password less than 6 characters if password with half-width alphanumeric characters" do
    store = Store.new(password: "ab123")
    store.valid?
    expect(store.errors[:password]).to include("は6文字以上に設定して下さい。")
  end
  #重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    Store.create(
      store_name: "テストストア",
      email: "test@email.com",
      password: "teststore",
      store_address: "東京都杉並区南阿佐ヶ谷４丁目",
      business_hours: "9:00 ~ 22:00"
    )
    store = Store.new(
      store_name: "テストスーパー",
      email: "test@email.com",
      password: "testsuper",
      store_address: "東京都杉並区南阿佐ヶ谷5丁目",
      business_hours: "7:00 ~ 21:00"
    )
    store.valid?
    expect(store.errors[:email]).to include("は既に使用されています。")
  end
end
