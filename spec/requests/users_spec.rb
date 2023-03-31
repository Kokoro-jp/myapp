require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end

  context 'userがsign inしている場合' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    let!(:post2) { create(:post) }

    before do
      sign_in user
    end

    it 'postsが正しく作成日時が新しい順に返却されること' do
      get('/users/home', headers:)
      res = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(res[0][:product_introduction]).to eq(post2.product_introduction)
      # 作成日時が新しい順に並んでいるかチェック
      expect(res[0][:id]).to eq(post2.id)
      expect(res[1][:id]).to eq(post.id)
    end

    context 'postが5つ以上作られている場合' do
      let!(:post3) { create(:post) }
      let!(:post4) { create(:post) }
      let!(:post5) { create(:post) }
      let!(:post6) { create(:post) }

      it 'postsが最大5件までしか返却されないこと' do
        get('/users/home', headers:)
        res = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:ok)
        expect(res.count).to eq(5)
      end
    end

    it 'current_userのfavoritesのみ返却されること' do
      get('/users/home', headers:)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'userがsign inしていない場合' do
    it 'users/homeのアクセスに失敗し、サインイン画面にリダイレクトする' do
      get('/users/home', headers:)
      expect(response).not_to have_http_status(:ok)
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end
