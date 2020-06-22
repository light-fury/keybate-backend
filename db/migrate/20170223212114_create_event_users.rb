class CreateEventUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_users, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :event, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
