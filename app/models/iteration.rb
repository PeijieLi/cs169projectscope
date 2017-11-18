class Iteration < ActiveRecord::Base
    has_many :comments
    
    def get_comments(project)
        comments.where(project_id: project.id)
    end
end
