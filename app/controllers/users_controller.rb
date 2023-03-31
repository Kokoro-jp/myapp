class UsersController < ApplicationController
  before_action :autheniticate_user, unless: :user_signed_in?

  def home
    @posts = Post.all.order('created_at DESC').limit(5)
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @user = current_user

    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
    respond_to do |format|
      format.html
      format.json { render json: @favorite_list }
    end
  end

  def destroy
    @user.destroy
    redirect_to :root, notice: t(:withdrawal_successfully)
  end
end
