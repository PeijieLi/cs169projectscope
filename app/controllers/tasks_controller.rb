class TasksController < ApplicationController

	def new
        @iteration = Iteration.find(session['iteration_id'])
        @all_tasks =  Task.where('iteration_id': session['iteration_id']).uniq.pluck(:title)
        if !@all_tasks
            @all_tasks =[]
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def progress
        @task = Task.find(params[:id])
        @report = Taskreport.where(task_id: @task.id, project_id: session['project_id']).first
    end

    def change_progress
        @report = Taskreport.find(params[:id])
        @curr_task = Task.find(params['task_id'])
        parents = @curr_task.parents
        if parents.length == 0 or params["status"] != "Completed"
            @report.status = params["status"]
            @report.save
        else
            # need to make sure that all parents are completed
            if parents.all? {|t| Taskreport.get_report(t.id, session['project_id']) == "Completed"}
                @report.status = params["status"]
                @report.save
            else
                flash[:message] = "Must Complete parent task first!"
            end
        end
        redirect_to iteration_path(id: session['iteration_id']), :id => session['iteration_id']
    end

    def update
        task_params = params["task"]
        to_sub = {} #this is the new array we will pass to Iteration to create a new iteration
        to_sub["title"] = task_params["title"]
        to_sub["description"] = task_params["description"]
        # store updates to session (merge with current)
        if session['task_updates'].has_key? params[:id]
            old = session['task_updates'][params[:id]]
            session['task_updates'][params[:id]] = old.merge(to_sub)
        else
            session['task_updates'][params[:id]] = to_sub
        end
        # @task = Task.find params[:id]
        # @task.update_attributes!(to_sub)
        redirect_to iteration_path(id: session['iteration_id'])
    end

    def destroy
        if session['dying_tasks'] == nil
            session['dying_tasks'] = []
        end
        session['dying_tasks'].push(params[:id])
        # Task.find(params[:id]).destroy
        redirect_to iteration_path(id: session['iteration_id'])
    end


    def create
        @iteration = Iteration.find(session['iteration_id'])
        @tasks = Task.where('iteration_id': session['iteration_id'])
        if !@tasks
            @tasks =[]
        end
        parants_param = params[:tasks]
        task_param = params[:task]
        if task_param[:title].nil?or task_param[:description].nil? or task_param[:title].empty? or task_param[:description].empty?
            flash[:message]="Please fill in all required fields"
            puts("redirect because empty")
            redirect_to iteration_path(id: session['iteration_id'])
            return
        end
        new_task = Task.new
        new_task.title=task_param[:title]
        new_task.description=task_param[:description]
        new_task.iteration = @iteration
        new_task.save
        # create new task report for each project
        current_course = Course.find(session['course_id'])
        all_project = Project.where(course_id: current_course.id)
        all_project.each do |p|
            new_task.taskreports.create(:task_id => new_task.id, :project_id => p.id)
        end
        #added all the checked tasks to parents
        @tasks.each do |p|
            if !p.title.nil? 
                if !parants_param.nil? and parants_param[p.title]=="true"
                    new_task.add_parent(p)
                end
            end
        end
        ##need to add display message and direct to some page 
        flash[:message]= "Successfully created task"
        redirect_to iteration_path(id: session['iteration_id'])
    end


end
