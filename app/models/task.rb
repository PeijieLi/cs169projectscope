class Task < ActiveRecord::Base
	belongs_to :iteration
	has_many :parents, class_name: "Task"
	has_many :projects, :through => :taskreports
	has_many :taskreports

	def add_parent(p)
		self.parents.push(p)
		self.save
    end
end
