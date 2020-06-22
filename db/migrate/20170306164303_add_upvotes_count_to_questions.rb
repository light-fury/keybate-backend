class AddUpvotesCountToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :upvotes_count, :integer, default: 0
  end
end
