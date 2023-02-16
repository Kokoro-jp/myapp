class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_any!
    if store_signed_in?
      true
    else
      authenticate_user!
    end
  end

  def set_current_user
    @current_user = User.find_by(id(:session[:user_id]))
  end

  def autheniticate_user
    return unless @current_user.nil?

    redirect_to new_user_session_path, notice: t(:need_login)
  end

  def set_current_store
    @current_store = Store.find_by(id: session[:store_id])
  end

  def autheniticate_store
    return unless @current_store.nil?

    redirect_to new_store_session_path, notice: t(:need_login)
  end

  def after_sign_in_path_for(_resource)
    if resource_class == User
      users_home_path
    elsif resource_class == Store
      stores_home_path
    end
  end

  def after_sign_out_path_for(_resource)
    if resource_class == User
      new_user_session_path
    elsif resource_class == Store
      new_store_session_path
    end
  end

  private

  def configure_permitted_parameters
    if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
    elsif resource_class == Store
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[store_name store_address business_hours])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[store_name store_address business_hours])
    end
  end
end
