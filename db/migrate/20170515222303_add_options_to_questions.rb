class AddOptionsToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :hidden, :boolean, default: false
    add_column :questions, :pinned_to_top, :boolean, default: false
    add_column :questions, :sent_to_bottom, :boolean, default: false
    add_column :questions, :deleted, :boolean, default: false
    add_column :questions, :allowed, :boolean, default: false
    add_column :questions, :time_displayed, :datetime
    add_column :questions, :time_pinned, :datetime
  end
end
