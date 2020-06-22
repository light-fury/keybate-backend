class CreateEventAgendas < ActiveRecord::Migration[5.0]
  def change
    create_table :event_agendas, id: :uuid do |t|
      t.references :event, type: :uuid, foreign_key: true

      t.date :date
      t.time :time_start
      t.time :time_end
      t.string :title

      t.timestamps
    end
  end
end
