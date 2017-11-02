class AddTasksToTaskreports < ActiveRecord::Migration
  def change
    add_reference :taskreports, :task, index: true, foreign_key: true
  end
end
