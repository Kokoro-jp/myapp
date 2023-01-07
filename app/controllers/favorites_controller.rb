class FavoritesController < ApplicationController
  before_action :autheniticate_user, unless: :user_signed_in?
  before_action :post_params

  def create
    Favorite.create(user_id: current_user.id, post_id: params[:id])
  end

  def destroy

    Favorite.find_by(user_id: current_user.id, post_id: params[:id]).destroy

  end

  private

  def post_params
    @post = Post.find(params[:id])
  end

end
