class AddJtiToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :Jti, :string, null: false
    add_index :users, :Jti, unique: true
  end
end
