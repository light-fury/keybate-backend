class AddBlockedToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :blocked, :boolean, default: false
  end
end
