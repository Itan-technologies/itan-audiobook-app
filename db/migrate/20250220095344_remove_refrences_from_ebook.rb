class RemoveRefrencesFromEbook < ActiveRecord::Migration[7.1]
  def change
    remove_reference :ebooks, :user, foreign_key: true, type: :uuid
  end
end
