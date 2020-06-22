class AddDisplayResultsToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :display_results, :boolean, default: false
  end
end
