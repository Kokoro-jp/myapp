class UsersController < ApplicationController

  def home
  end
  
  def new
    @user = current_user.id
  end

  def show
    @user = current_user
  end

end
