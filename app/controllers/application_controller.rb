class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

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

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end

end
