class AddColorToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :color, :string
  end
end
