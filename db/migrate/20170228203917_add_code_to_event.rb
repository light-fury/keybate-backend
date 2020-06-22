class AddCodeToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :code, :string
    add_index :events, :code, unique: true
  end
end
