class StudentTask < ActiveRecord::Base
    has_many :parents, class_name: "StudentTask"
    belongs_to :iteration
    belongs_to :project
    def add_parent(p)
        self.parents.push(p)
        self.save
    end
     def get_parents
        self.parents.map {|p| "\"#{p.title}\""}.join(',')
    end
    def is_blocked
        if self.parents.empty?
            return false
        else
            self.parents.each do |p|
                if p.status != "Finished"
                    return true
                end
            end
            return false
        end
        
    end
end
