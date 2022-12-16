class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      flash[:notice] = "投稿が完了しました"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:product_img, :product_introduction)
  end
end
