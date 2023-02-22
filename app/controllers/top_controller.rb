class TopController < ApplicationController
  before_action :set_q, only: %i[index]
  def index
    @posts = if store_signed_in?
               Post.where(store_id: current_store.id).includes(:store).limit(5).order('created_at DESC')
             else
               Post.limit(5).order('created_at DESC')
             end
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def set_q
    @q = Post.ransack(params[:q])
  end
end
