class AddUserToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :user, type: :uuid, foreign_key: true
  end
end
