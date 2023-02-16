class TopController < ApplicationController
  def index
    @posts = if store_signed_in?
               Post.where(store_id: current_store.id).where.not(product_img: nil)
                   .includes(:store).limit(5).order('created_at DESC')
             else
               Post.all.where.not(product_img: nil).limit(5).order('created_at DESC')
             end
  end
end
