class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :company_name
      t.string :job_name
      t.string :country
      t.string :picture

      t.datetime :joined_at
      t.datetime :left_at
      t.integer  :room_id
      t.datetime :requested_call_at
      t.datetime :hung_up_at

      t.timestamps
    end
  end
end
