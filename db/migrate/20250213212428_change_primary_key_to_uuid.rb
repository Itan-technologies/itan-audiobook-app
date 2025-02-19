# frozen_string_literal: true

def up
  enable_pgcrypto
  create_users_table
  copy_old_users_data
  rename_tables
  drop_old_users_table
end

private

def enable_pgcrypto
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
end

def create_users_table
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
end

def copy_old_users_data
  execute <<-SQL
    INSERT INTO new_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at,#{' '}
                           remember_created_at, created_at, updated_at, role)
    SELECT gen_random_uuid(), email, encrypted_password, reset_password_token, reset_password_sent_at,#{' '}
           remember_created_at, created_at, updated_at, role
    FROM users;
  SQL
end

def rename_tables
  rename_table :users, :old_users
  rename_table :new_users, :users
end

def drop_old_users_table
  drop_table :old_users
end
