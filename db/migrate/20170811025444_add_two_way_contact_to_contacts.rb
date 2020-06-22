class AddTwoWayContactToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :two_way_contact, :boolean, default: false
    add_column :contacts, :blocked_by_id, :uuid, default: nil
    add_foreign_key :contacts, :users, column: :blocked_by_id, index: true, foreign_key: true
  end
end
