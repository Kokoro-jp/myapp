class UsersController < ApplicationController

  def home
  end
  

  def show
    @user = current_user
  end

end
