class AddCallableToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :callable, :boolean, default: false
  end
end
