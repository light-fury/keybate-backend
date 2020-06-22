class AddIndexesToContacts < ActiveRecord::Migration[5.0]
  def change
    add_index :contacts, :from_user_id
    add_index :contacts, :to_user_id
  end
end
