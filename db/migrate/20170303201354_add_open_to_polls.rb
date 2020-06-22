class AddOpenToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :open, :boolean, default: false
  end
end
