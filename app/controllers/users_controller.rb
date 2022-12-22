class UsersController < ApplicationController
  before_action :autheniticate_user, unless: :user_signed_in?

  def home
    @posts = Post.all.where.not(product_img: nil)
  end

  def new
    @user = current_user.id
  end

  def show
    @user = current_user
  end

end
