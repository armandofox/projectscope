class AddprsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :gpa, :int
    add_column :projects, :coverage, :int 
    add_column :projects, :prs, :int
    add_column :projects, :slack, :int
    add_column :projects, :pts, :int
  end
end
