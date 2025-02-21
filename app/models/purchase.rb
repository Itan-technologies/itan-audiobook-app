class Purchase < ApplicationRecord
  belongs_to :audiobook
  belongs_to :ebook
  belongs_to :user
end
