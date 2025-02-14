class User < ApplicationRecord
  self.primary_key = 'id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  enum role: { listener: 'listener', author: 'author', admin: 'admin' }
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :author
  end
end
