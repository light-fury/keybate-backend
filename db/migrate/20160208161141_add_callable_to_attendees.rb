class AddCallableToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :callable, :boolean, default: false
  end
end
