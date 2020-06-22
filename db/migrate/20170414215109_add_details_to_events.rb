class AddDetailsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_date_start, :datetime
    add_column :events, :event_date_end, :datetime
    add_column :events, :cover, :string
    add_column :events, :description, :text
    add_column :events, :category, :string
    add_column :events, :location, :string
    add_column :events, :practical_information, :text
    add_column :events, :organizer_contact, :text
    add_column :events, :isLive, :bool, default: false
  end
end
