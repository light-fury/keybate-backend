class CreateEventSpeakers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_speakers, id: :uuid do |t|
      t.references :event, type: :uuid, foreign_key: true

      t.string :name
      t.text :affiliation
      t.string :picture
      t.text :biography
      t.string :role

      t.timestamps
    end
  end
end
