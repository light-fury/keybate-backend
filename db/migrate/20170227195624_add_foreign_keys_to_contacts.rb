class AddForeignKeysToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :to_user_id, :uuid
    add_column :contacts, :from_user_id, :uuid
    add_foreign_key :contacts, :users, column: :to_user_id, index: true, foreign_key: true
    add_foreign_key :contacts, :users, column: :from_user_id, index: true, foreign_key: true
  end
end
