class RenamePinToQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :pinnedByModerator, :pinned_by_moderator
  end
end
