class ChangeFollowerToUser < ActiveRecord::Migration
  def change
    rename_column :favorites, :follower_id, :user_id
  end
end
