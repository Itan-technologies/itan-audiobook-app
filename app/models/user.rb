class User < ApplicationRecord
  before_create :skip_confirmation_for_admin
  after_initialize :set_default_role, if: :new_record?
  self.primary_key = 'id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum role: { listener: 'listener', author: 'author', admin: 'admin' }

  # Associations
  has_many :purchases, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_and_belongs_to_many :audiobooks, join_table: 'users_audiobooks'
  has_and_belongs_to_many :ebooks, join_table: 'users_ebooks'

  # Custom method to check if the user can sign in
  def active_for_authentication?
    super && (admin? || confirmed?)
  end

  # Custom message for unconfirmed authors
  def inactive_message
    if author? && !confirmed?
      :unconfirmed
    else
      super
    end
  end

  private

  def set_default_role
    self.role ||= :author
  end

  def skip_confirmation_for_admin
    skip_confirmation! if admin?
  end
end
