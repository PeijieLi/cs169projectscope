class AddCourseIdToIterations < ActiveRecord::Migration
  def change
    add_column :iterations, :course_id, :integer
  end
end
