class CreateFavoriteQuestions < ActiveRecord::Migration
  def change
    create_table :favorite_questions do |t|
      t.references :user
      t.references :question
      t.string     :room_name
      
      t.timestamps null: false
    end
  end
end
