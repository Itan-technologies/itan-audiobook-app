class CreateUsersAudiobooks < ActiveRecord::Migration[7.1]
  def change
    create_table :users_audiobooks, id: false do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :audiobook, null: false, foreign_key: true, type: :uuid
   
      t.timestamps
    end

    unless index_exists?(:users_audiobooks, [:user_id, :audiobook_id], unique: true)
      add_index :users_audiobooks, [:user_id, :audiobook_id], unique: true
    end

    unless index_exists?(:users_audiobooks, :user_id)
      add_index :users_audiobooks, :user_id
    end

    unless index_exists?(:users_audiobooks, :audiobook_id)
      add_index :users_audiobooks, :audiobook_id
    end
  end
end
