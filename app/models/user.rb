class User < ApplicationRecord
  self.primary_key = 'id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Denylist

  enum role: { listener: 'listener', author: 'author', admin: 'admin' }
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :author
  end

  def jwt_payload
    {
      sub: id,  # User ID
      email: email,  # User email
      role: "listener",  # User role
      exp: 1.days.from_now.to_i # Token expiration (optional)
    }
  end
end
