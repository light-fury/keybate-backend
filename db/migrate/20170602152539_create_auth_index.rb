class CreateAuthIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end
end
