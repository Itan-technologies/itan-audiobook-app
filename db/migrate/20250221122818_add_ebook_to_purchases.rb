class AddEbookToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :ebook_id, :uuid
    add_foreign_key :purchases, :ebooks, column: :ebook_id
    add_index :purchases, :ebook_id
  end
end
