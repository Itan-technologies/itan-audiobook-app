class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index; end

  def ensure_admin!
    return if current_user.admin?

    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end
end
