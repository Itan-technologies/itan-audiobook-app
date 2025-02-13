class ApplicationController < ActionController::Base
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
end
