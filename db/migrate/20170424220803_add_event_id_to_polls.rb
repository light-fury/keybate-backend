class AddEventIdToPolls < ActiveRecord::Migration[5.0]
  def change
    add_reference :polls, :event, type: :uuid, foreign_key: true
  end
end
