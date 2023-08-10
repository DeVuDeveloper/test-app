class ApplicationController < ActionController::Base
  rescue_from Cookies::CreateService::ValidationError, with: :render_form_with_errors
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:password, :password_confirmation, :current_password)
    end
  end

  def render_form_with_errors(exception)
    @cookie = exception.cookie
    redirect_to new_oven_path, status: :unprocessable_entity
  end
end
