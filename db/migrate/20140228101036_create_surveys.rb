class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :user_id
      t.string :url
      t.string :category
      t.string :title

      t.timestamps

    end
  end
end
