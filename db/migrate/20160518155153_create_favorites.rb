class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :follower_id
      t.integer :following_id
      t.boolean :met_in_room, default: false
      t.integer :room_id
      t.string  :room_name

      t.timestamps null: false
    end
  end
end
