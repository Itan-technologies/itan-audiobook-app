# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # Override create method to avoid Devise double rendering
  def create
    user = warden.authenticate!(auth_options)
    render_login_response(user)
  end

  private

  def render_login_response(resource)
    return if performed? # Prevent double rendering

    render json: {
      status: {
        code: 200,
        message: 'Logged in successfully'
      },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    return if performed? # Prevent double rendering

    if warden.authenticated?(:user)
      render json: { status: 200, message: "Logged out successfully" }, status: :ok
    else
      render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
    end
  end
end
