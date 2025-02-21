class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :audiobook, null: false, foreign_key: true, type: :uuid
      t.references :ebook, null: false, foreign_key: true, type: :uuid
      t.integer :rating
      t.string :comments

      t.timestamps
    end
  end
end
