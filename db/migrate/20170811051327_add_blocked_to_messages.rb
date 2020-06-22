class AddBlockedToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :blocked, :boolean, default: false
  end
end
