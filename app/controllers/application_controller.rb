# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password password_confirmation current_password role])
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      render json: { message: 'Admin login successful', redirect_url: admin_dashboard_path }
    elsif resource.author?
      render json: { message: 'Author login successful', redirect_url: authors_dashboard_path }
    else
      render json: { message: 'Login successful', redirect_url: root_path }
    end
  end
end
