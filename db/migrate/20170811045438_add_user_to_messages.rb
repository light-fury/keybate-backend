class AddUserToMessages < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :user, type: :uuid, foreign_key: true
  end
end
