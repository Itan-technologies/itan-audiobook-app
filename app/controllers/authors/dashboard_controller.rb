class Authors::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_author!

  def index
  end

  private

    def ensure_author!
      unless current_user.author?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end

end
