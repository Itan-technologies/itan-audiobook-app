class AddIndexToEbooks < ActiveRecord::Migration[7.1]
  def change
    add_index :ebooks, :title
    add_index :ebooks, :primary_audience
  end
end
