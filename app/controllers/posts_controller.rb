class PostsController < ApplicationController
  before_action :autheniticate_store, except: [:index, :show, :search], unless: :store_signed_in?
  before_action :autheniticate_user, only: [:search], unless: :user_signed_in?
  before_action :set_post, only: [:show, :edit, :update, :destroy, :ensure_correct_store]
  before_action :set_q, only: [:index, :search]

  def index
    if store_signed_in?
      @posts = Post.where(store_id: current_store.id).where.not(product_img: nil).includes(:store).order("created_at DESC")
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
      flash[:notice] = "投稿が完了しました"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def show
    @store = Store.find(@post.store_id)
    impressionist(@post, nil, unique: [:ip_address])
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

  def search
    @results = @q.result.where.not(product_img: nil)
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end

  def post_params
    params.require(:post).permit(:product_img, :product_introduction, :store_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
