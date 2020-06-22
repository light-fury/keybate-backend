class AddUpvotesCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :upvotes_count, :integer, default: 0
  end
end
