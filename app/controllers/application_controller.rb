class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path # Redirect to the admin dashboard
    elsif resource.author?
      authors_dashboard_path # Redirect to the authors dashboard
    else
      root_path # Redirect to the root path for listeners or other roles
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password password_confirmation current_password])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
  end
end
