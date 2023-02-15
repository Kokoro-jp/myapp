class TopController < ApplicationController
  def index
    if store_signed_in?
      @posts = Post.where(store_id: current_store.id).where.not(product_img: nil)
                   .includes(:store).limit(5).order('created_at DESC')
    else
      @posts = Post.all.where.not(product_img: nil).limit(5).order('created_at DESC')
    end
  end
end
