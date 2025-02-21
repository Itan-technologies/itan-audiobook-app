class Audiobook < ApplicationRecord
  before_create :generate_unique_audio_id

  belongs_to :ebook
  has_and_belongs_to_many :users, join_table: 'users_audiobooks'
  has_many :reviews
  has_many :purchases
  has_many :chapters

  private

  def generate_unique_audio_id
    prefix = 'AOO'
    last_audiobook = Audiobook.order(:created_at).last
    last_number = last_audiobook&.unique_audio_id&.gsub(prefix, '')&.to_i || 1000
    self.unique_audio_id = "#{prefix}#{last_number + 1}"
  end
end
