# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  self.primary_key = 'id'

  # Include default Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  # Role-based authorization
  enum role: { listener: 'listener', author: 'author', admin: 'admin' }

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= 'author' # Use string, not symbol
  end

  # def jwt_payload
  #   {
  #     sub: id,  # User ID
  #     email: email,  # User email
  #     role: role,  # Dynamically set user role
  #     exp: 1.day.from_now.to_i # Token expiration
  #   }
  # end
end
