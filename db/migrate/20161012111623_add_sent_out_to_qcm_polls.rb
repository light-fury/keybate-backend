class AddSentOutToQcmPolls < ActiveRecord::Migration
  def change
    add_column :qcm_polls, :sent_out, :bool, default: false
  end
end
