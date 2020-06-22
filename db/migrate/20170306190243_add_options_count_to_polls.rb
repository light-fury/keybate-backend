class AddOptionsCountToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :options_count, :integer, default: 0
  end
end
