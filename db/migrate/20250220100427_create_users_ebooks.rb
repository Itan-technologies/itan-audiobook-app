class CreateUsersEbooks < ActiveRecord::Migration[7.1]
  def change
    create_table :users_ebooks, id: false do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :ebook, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    
    add_index :users_ebooks, [:user_id, :ebook_id], unique: true
  end
end
