class CreateEbooks < ActiveRecord::Migration[7.1]
  def change
    create_table :ebooks, id: :uuid do |t|      
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.text :description
      t.string :edition_number
      t.string :contributors
      t.integer :primary_audience
      t.boolean :publishing_rights
      t.string :file_url
      t.string :cover_image_url
      t.integer :status
      t.integer :price
      t.string :unique_ebook_id

      t.timestamps
    end
  end
end
