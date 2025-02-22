class CreateChapters < ActiveRecord::Migration[7.1]
  def change
    create_table :chapters, id: :uuid do |t|
      t.references :audiobook, null: false, foreign_key: true, type: :uuid
      t.references :ebook, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.string :audio_file_url
      t.integer :duration

      t.timestamps
    end
  end
end
