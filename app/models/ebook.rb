class Ebook < ApplicationRecord
  before_create :generate_unique_ebook_id

  has_and_belongs_to_many :users, join_table: 'users_ebooks'
  has_one :audiobook
  has_many :reviews
  has_many :purchases
  has_many :chapters

  private

  def generate_unique_ebook_id
    prefix = 'BOO'
    last_ebook = Ebook.order(:created_at).last
    last_number = last_ebook&.unique_ebook_id&.gsub(prefix, '')&.to_i || 1000
    self.unique_ebook_id = "#{prefix}#{last_number + 1}"
  end
end
