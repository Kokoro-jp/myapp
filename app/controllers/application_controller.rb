class ApplicationController < ActionController::Base
  before_action :authenticate_user!   #Toppage はskip_before_actionで解除
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    elsif resource_class == Store
      devise_parameter_sanitizer.permit(:sign_up, keys: [:store_name, :store_address, :business_hours])
    end
  end
end
