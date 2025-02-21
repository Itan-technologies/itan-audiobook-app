class Chapter < ApplicationRecord
  belongs_to :audiobook
  belongs_to :ebook
end
