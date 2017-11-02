class Course < ActiveRecord::Base
	belongs_to :user
	has_many :projects
	has_many :iterations

	validate :owner_is_instructor

	private

	def owner_is_instructor
		errors.add(:user, "Course owner must be instructor") unless user && user.is_instructor?
	end

	public

	def has_iteration?
		iterations = self.iterations
		return iterations.length != 0
	end

	def get_all_iterations
		return Iteration.where(course_id: self.id).order(:id)
	end

end
