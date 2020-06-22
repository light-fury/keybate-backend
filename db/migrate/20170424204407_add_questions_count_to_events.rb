class AddQuestionsCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :questions_count, :integer, default: 0
  end
end
