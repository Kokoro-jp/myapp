require 'rails_helper'

RSpec.describe 'Top', type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end

  context 'sign inしていない場合' do
    let!(:post) { create(:post) }
    let!(:post2) { create(:post) }

    it 'postsが正しく作成日時が新しい順に返却されること' do
      get('/', headers:)
      res = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(res[0][:product_introduction]).to eq(post2.product_introduction)
      expect(res[0][:store_id]).to eq(post2.store_id)
      expect(res[0][:impressions_count]).to eq(post2.impressions_count)
      # 新しい順に並んでいるかチェック
      expect(res[0][:id]).to eq(post2.id)
      expect(res[1][:id]).to eq(post.id)
    end

    context 'postが5つ以上作られている場合' do
      let!(:post3) { create(:post) }
      let!(:post4) { create(:post) }
      let!(:post5) { create(:post) }
      let!(:post6) { create(:post) }
      it 'postsが最大5件までしか返却されないこと' do
        get('/', headers:)
        res = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:ok)
        expect(res.count).to eq(5)
      end
    end
  end

  context 'sign inしている場合' do
    let!(:store) { create(:store) }
    let!(:store2) { create(:store) }
    let!(:post7) { create(:post, store_id: store.id) }
    let!(:post8) { create(:post, store_id: store.id) }
    let!(:post9) { create(:post, store_id: store_2.id) }

    before do
      sign_in store
    end

    it 'current_storeの投稿のみ表示され、作成日時が新しい順に並んでいること' do
      get('/', headers:)
      res = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(res[0][:product_introduction]).to eq(post7.product_introduction)
      expect(res[2]).to be nil

      # 作成日時が新しい順に並んでいるか
      expect(res[0][:id]).to eq(post8.id)
      expect(res[1][:id]).to eq(post7.id)
    end

    context 'current_storeのpostが5つ以上作られている場合' do
      let!(:post10) { create(:post, store_id: store.id) }
      let!(:post11) { create(:post, store_id: store.id) }
      let!(:post12) { create(:post, store_id: store.id) }
      let!(:post13) { create(:post, store_id: store.id) }

      it 'current_storeのpostsが最大5件までしか返却されないこと' do
        get('/', headers:)
        res = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:ok)
        expect(res.count).to eq(5)
      end
    end
  end
end
