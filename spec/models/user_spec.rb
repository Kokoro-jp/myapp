require 'rails_helper'

RSpec.describe User, type: :model do
  #有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  #バリデーションのテスト
  describe "validates test" do
    #ユーザー名、メール、パスワードがあれば有効な状態であること
    it "is valid with a user_name, email, and password" do
      user = User.new(
        user_name: "Taro",
        email: "test@example.com",
        password: "password"
      )
      expect(user).to be_valid
    end
    #ユーザー名がなければ無効な状態であること
    it "is invalid without a user_name" do
      user = build(:user, user_name: nil)
      user.valid?
      expect(user.errors[:user_name]).to include("が入力されていません。")
    end
    #メールがなければ無効な状態であること
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end
    #passwordが無ければ無効な状態であること
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end
    #passwordが半角英数字のみを使用していても6文字以下なら無効な状態であること
    it "is invalid with password less than 6 characters if password with half-width alphanumeric characters" do
      user = build(:user, password: "abc12")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end
    #重複したメールアドレスなら無効な状態であること
    it "is invalid with a duplicate email address" do
      user = create(:user, email: "aaron@example.com")
      user = build(:user, email: "aaron@example.com")
      user.valid?
      expect(user.errors[:email]).to include("は既に使用されています。")
    end
    #passwordとconfirmが一致していないと無効な状態であること
    it "is invalid password doesn't match password_confirmation" do
      user = build(:user, password: "password", password_confirmation: "123456")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("が内容とあっていません。")
    end
  end
end
