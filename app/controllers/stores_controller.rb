class StoresController < ApplicationController

  def home
    @store = Store.find_by(params[:id])
  end

  def new
    @store = current_store.id
  end

  def show
    @store = current_store
  end

end
