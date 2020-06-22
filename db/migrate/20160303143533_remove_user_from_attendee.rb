class RemoveUserFromAttendee < ActiveRecord::Migration
  def change
    remove_column :attendees, :first_name
    remove_column :attendees, :last_name
    remove_column :attendees, :email
    remove_column :attendees, :company_name
    remove_column :attendees, :job_name
    remove_column :attendees, :country
    remove_column :attendees, :picture
  end
end
