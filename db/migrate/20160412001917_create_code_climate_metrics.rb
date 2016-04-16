class CreateCodeClimateMetrics < ActiveRecord::Migration
  def change
    create_table :code_climate_metrics do |t|
      t.float :score
      t.float :gpa
      t.integer :coverage
      t.string :url
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :code_climate_metrics, :project_id
  end
end
