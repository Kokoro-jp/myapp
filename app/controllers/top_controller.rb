class TopController < ApplicationController

  def index
    @posts = Post.all.order("created_at DESC").limit(5)
  end

end
