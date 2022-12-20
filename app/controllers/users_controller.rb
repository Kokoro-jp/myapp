class UsersController < ApplicationController

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
