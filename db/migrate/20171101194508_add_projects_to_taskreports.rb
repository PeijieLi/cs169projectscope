class AddProjectsToTaskreports < ActiveRecord::Migration
  def change
  	add_reference :taskreports, :project, index: true, foreign_key: true
  end
end
