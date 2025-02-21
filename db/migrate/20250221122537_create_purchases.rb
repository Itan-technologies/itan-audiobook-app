class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases, id: :uuid do |t|
      t.references :audiobook, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :amount
      t.string :purchase_status
      t.datetime :purchase_date
      t.string :paystack_reference

      t.timestamps
    end
  end
end
