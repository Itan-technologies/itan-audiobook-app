class ApplicationController < ActionController::API
  include Response

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

