class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.string :title
      t.text :description
      t.references :user, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
