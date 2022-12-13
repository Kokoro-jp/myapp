class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource_class == User
      users_home_path
    elsif resource_class == Store
      stores_home_path
    end
  end
  def after_sign_out_path_for(resource)
    if resource_class == User
      new_user_session_path 
    elsif resource_class == Store
      new_store_session_path
    end
  end
end
