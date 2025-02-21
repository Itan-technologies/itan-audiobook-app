class Review < ApplicationRecord
  belongs_to :user
  belongs_to :audiobook
  belongs_to :ebook
end
