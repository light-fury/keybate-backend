class AddListOrderToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :list_order, :integer, default: nil
  end
end
