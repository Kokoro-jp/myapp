class UsersController < ApplicationController
  before_action :autheniticate_user, unless: :user_signed_in?

  def home
    @posts = Post.all.where.not(product_img: nil).order("created_at DESC").limit(5)
  end

  def new
    @user = current_user.id
  end

  def show
    @user = current_user
    @posts = Post.all
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
  end

end
