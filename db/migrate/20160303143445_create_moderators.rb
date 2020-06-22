class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.integer  :room_id
      t.integer  :user_id

      t.timestamps null: false
    end
  end
end
