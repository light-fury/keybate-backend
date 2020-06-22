class AddUserIdAndIndexToUser < ActiveRecord::Migration
  def change
    add_column :users, :api_user_id, :string
    add_index :users, :api_user_id, unique: true
  end
end
