class AddPlanToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :plan, :string, default: 'pro'
  end
end
