class AddCourseIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :course_id, :integer
  end
end
