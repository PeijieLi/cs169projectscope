class Iteration < ActiveRecord::Base
	belongs_to :course
	has_many :tasks

	public
	def get_all_tasks_in_iteration
		return Task.where(iteration_id: self.id)
	end

	
end
