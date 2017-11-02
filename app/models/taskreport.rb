class Taskreport < ActiveRecord::Base
	belongs_to :project
	belongs_to :task

	def index
		@report = Taskreport.find(params[:id])
	end

	def self.get_report(task_id, project_id)
		reports = Taskreport.where(project_id: project_id, task_id: task_id)
		if !reports.empty?
			report = reports.first
			if report.status
				return report.status
			else
				return "Incomplete"
			end
		else
			return "Incomplete"
		end
	end

	public

	def get_status
		if self.status
			return self.status
		else
			return "Incomplete"
		end
	end

end
