# frozen_string_literal: true

class ChangePrimaryKeyToUuid < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    # Create a new table with UUID as primary key
    create_table :new_users, id: :uuid do |t|
      t.string :email, default: '', null: false
      t.string :encrypted_password, default: '', null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :role
      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end

    # Copy data from old table to new table
    execute <<-SQL
      INSERT INTO new_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, role)
      SELECT gen_random_uuid(), email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, role
      FROM users;
    SQL

    # Rename old table and new table
    rename_table :users, :old_users
    rename_table :new_users, :users

    # Drop old table
    drop_table :old_users
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
