class PostsController < ApplicationController

  def index
    @posts = Post.all.where.not(product_img: nil)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # store_id = @current_store.id
    if @post.save
      binding.pry
      flash[:notice] = "投稿が完了しました"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path, notice: "編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました"
    else
      flash.now[:danger] = "削除に失敗しました"
      render "show"
    end
  end

  private
  def post_params
    params.require(:post).permit(:product_img, :product_introduction)
  end
end
