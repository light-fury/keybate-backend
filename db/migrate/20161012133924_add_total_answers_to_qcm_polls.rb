class AddTotalAnswersToQcmPolls < ActiveRecord::Migration
  def change
    add_column :qcm_polls, :total_answers, :integer, default: 0
  end
end
