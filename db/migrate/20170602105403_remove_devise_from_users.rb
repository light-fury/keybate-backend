class RemoveDeviseFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :reset_password_token
    remove_column :users, :encrypted_password, :string
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :string
    remove_column :users, :remember_created_at, :string
    remove_column :users, :sign_in_count, :string
    remove_column :users, :current_sign_in_at, :string
    remove_column :users, :last_sign_in_at, :string
    remove_column :users, :current_sign_in_ip, :string
    remove_column :users, :last_sign_in_ip, :string
  end
end
