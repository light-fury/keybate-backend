class CreateQcmPolls < ActiveRecord::Migration
  def change
    create_table :qcm_polls do |t|
      t.string :question
      t.string :option_a
      t.integer :option_a_score, default: 0
      t.string :option_b
      t.integer :option_b_score, default: 0
      t.string :option_c
      t.integer :option_c_score, default: 0
      t.string :option_d
      t.integer :option_d_score, default: 0
      t.references :moderator
      t.references :room

      t.timestamps null: false
    end
  end
end
