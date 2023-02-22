class PostsController < ApplicationController
  before_action :autheniticate_store, except: %i[index show search], unless: :store_signed_in?
  before_action :set_post, only: %i[show edit update destroy] # ensure_correct_store
  before_action :set_q, only: %i[index search]

  def index
    @posts = if store_signed_in?
               Post.where(store_id: current_store.id).includes(:store).order('created_at DESC')
             else
               Post.all
             end
  end

  def show
    @store = Store.find(@post.store_id)
    impressionist(@post, nil, unique: [:ip_address])
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: t(:created_post)
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path, notice: t(:updated)
    else
      flash.now[:danger] = '編集に失敗しました'
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: t(:deleted_post)
    else
      flash.now[:danger] = '削除に失敗しました'
      render 'show'
    end
  end

  def search
    @results = @q.result
  end

  def set_q
    @q = Post.ransack(params[:q])
  end

  private

  def post_params
    params.require(:post).permit(:product_img, :product_introduction, :store_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
