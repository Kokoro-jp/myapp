class StoresController < ApplicationController

  before_action :autheniticate_store, unless: :store_signed_in?

  def home
    @store = Store.find(current_store.id)
    @posts = Post.where(store_id: current_store.id).where.not(product_img: nil).includes(:store).order(impressions_count: 'DESC')
  end

  def new
    @store = current_store.id
  end

  def show
    @store = current_store
  end

end
