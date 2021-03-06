class ApplicationController < ActionController::Base
  include AjaxErrorRenderer
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :sex, :height])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :sex, :height])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :sex, :height])
  end

  def after_sign_in_path_for(resource)
    posts_path
  end
end
