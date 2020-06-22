class CreateAnsweredPolls < ActiveRecord::Migration
  def change
    create_table :answered_polls do |t|
      t.string :option_letter
      t.string :answer_text
      t.string :room_name
      t.references :qcm_poll
      t.references :user
      t.references :room

      t.timestamps null: false
    end
  end
end
