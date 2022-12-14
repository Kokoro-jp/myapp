class StoresController < ApplicationController

  def home
  end

  def show
    @store = current_store
  end

end
