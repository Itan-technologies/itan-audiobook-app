class CreateAudiobooks < ActiveRecord::Migration[7.1]
  def change
    create_table :audiobooks, id: :uuid do |t|
      t.references :ebook, null: false, foreign_key: true, type: :uuid
      t.string :audio_file_url
      t.integer :duration
      t.boolean :status
      t.string :unique_audio_id
      t.string :title

      t.timestamps
    end
    add_index :audiobooks, :title 
  end
end
