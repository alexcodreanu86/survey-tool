class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t| 
      t.integer :question_id
      t.string :content
    end
  end
end
