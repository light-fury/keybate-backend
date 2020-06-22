class AddPublishedToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :published, :boolean, default: false
  end
end
