class CreateQuestions < ActiveRecord::Migration
  def change
  	create_table :questions do |t|
      t.integer :survey_id
      t.string :prompt
      t.string :type

      t.timestamps
  	end
  end
end
