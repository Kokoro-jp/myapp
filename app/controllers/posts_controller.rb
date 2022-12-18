class PostsController < ApplicationController
  before_action :autheniticate_store, except: [:index, :show], unless: :store_signed_in?
  before_action :set_post, only: [:show, :edit, :update, :destroy, :ensure_correct_store]

  def index
    if store_signed_in?
      @posts = Post.where(store_id: current_store.id).includes(:store).order("created_at DESC")
    else
      @posts = Post.all.where.not(product_img: nil)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      binding.pry
      flash[:notice] = "投稿が完了しました"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path, notice: "編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render "edit"
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました"
    else
      flash.now[:danger] = "削除に失敗しました"
      render "show"
    end
  end

  private
  def post_params
    params.require(:post).permit(:product_img, :product_introduction, :store_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # posts/show.html.erbで制御してるため不要かも

  # def ensure_correct_store
  #   if current_store.id != @post.store_id
  #     flash[:notice] = "権限がありません"
  #     redirect_to posts_path
  #   end
  # end

end
