class Ebook < ApplicationRecord
  has_and_belongs_to_many :users, join_table: 'users_ebooks'
  belongs_to :audiobook
  has_one :audiobook
  has_many :reviews
  has_many :purchases
  has_many :chapters
end
