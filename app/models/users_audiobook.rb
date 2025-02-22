class UsersAudiobook < ApplicationRecord
  belongs_to :user
  belongs_to :audiobook
end
