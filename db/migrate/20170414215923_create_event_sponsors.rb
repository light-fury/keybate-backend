class CreateEventSponsors < ActiveRecord::Migration[5.0]
  def change
    create_table :event_sponsors, id: :uuid do |t|
      t.references :event, type: :uuid, foreign_key: true

      t.string :name
      t.string :contact_email
      t.string :picture
      t.text :description

      t.timestamps
    end
  end
end
