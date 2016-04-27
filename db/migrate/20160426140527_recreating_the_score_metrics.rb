class RecreatingTheScoreMetrics < ActiveRecord::Migration
  def change
    drop_table :projects
    create_table :projects do |t|
      t.string :name
      t.float :gpa
      t.integer :coverage
      t.float :prs
      t.float :slack
      t.float :pts
      

      t.timestamps null: false
    end
  end
end
