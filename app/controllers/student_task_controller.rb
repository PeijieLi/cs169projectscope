class StudentTaskController < ApplicationController
    #load the form for new task
    #show the tasks for a team for a selected the iteration
    def index
        team = current_user.project
        iter = params[:iter]
        #testing only purpose
        if team==nil
            team = Project.all[0]
        end
        
        @tasks = StudentTask.where('iteration_id': iter, 'project_id': team.id)
        #to do : display the tasks in the view
        
    end
    #retrive the form for adding a new customized task for a team/project
    def new
        team_id = params[:team]
        @team = Project.find(team_id)
        iteration_id = params[:iter]
        @iteration = Iteration.find(iteration_id)
        @all_tasks = StudentTask.where('iteration_id': iteration_id, 'project_id': team_id)
        
    end
    #save the new task
    def create
        team_id = params[:team]
        @team = Project.find(team_id)
        iteration_id = params[:iter]
        @iteration = Iteration.find(iteration_id)
        new_added = StudentTask.new
        new_added.iteration = @iteration
        new_added.project = @team
        task_param = params[:task]
        parents_param = params[:tasks]
        new_added.title = task_param[:title]
        new_added.description = task_param[:description]
        new_added.save!
        @tasks = StudentTask.where('iteration_id': iteration_id, 'project_id': team_id)
        if !@tasks
            @tasks =[]
        end
        @tasks.each do |p|
            if !p.title.nil? 
                if !parents_param.nil? and parents_param[p.title]=="true"
                    new_added.add_parent(p)
                end
            end
        end
   
        ##need to add display message and direct to some page 
        flash[:message]= "Successfully create the task"
        redirect_to edit_student_task_path(new_added.id)
    
    end
    def destroy
        @target = StudentTask.find(params[:id])
        iter_id=@target.iteration_id
        team_id=@target.project_id
        if @target !=nil
            @target.destroy
        end
        flash[:message]= "Successfully delete the task"
        redirect_to show_a_team_path(:iter =>iter_id,:team =>team_id)
    end
    #retrive the form for editing a task(instructor only)
    def edit
        @task = StudentTask.find(params[:id])
        @parents = StudentTask.where('iteration_id': @task.iteration_id, 'project_id': @task.project_id)
        #to do : display the task in the view
        @selected_parents = @task.parents
    end
    
    #save the change made by an instructor
    def saveChange
        @target_task = StudentTask.find(params[:id])
        #get all the information from the form submitted and save the change to targe task
     
        @tasks = StudentTask.where('iteration_id': @target_task.iteration_id, 'project_id': @target_task.project_id)
        if !@tasks
            @tasks =[]
        end
        parents_param = params[:tasks]
        task_param = params[:task]
        @target_task.title = task_param[:title]
        @target_task.description = task_param[:description]
        @target_task.parents.clear
        @target_task.save!
        @tasks.each do |p|
            if !p.title.nil? 
                if !parents_param.nil? and parents_param[p.title]=="true"
                    @target_task.add_parent(p)
                end
            end
        end
   
        ##need to add display message and direct to some page 
        flash[:message]= "Successfully saved the change"
   
        ## to do: need to redirect but need to show the team view but not implemented yet
        redirect_to edit_student_task_path(params[:id])
        
    end
    
    #change the status of a task from student
    def updateStatus
        
    end
    
    #show the graph for all the teams for instructor
    def showAllForInstuctor
        @iter = params[:iter]
        @tasks = StudentTask.where('iteration_id': @iter)
        @teams = Project.all
        #to do: display the graph for each team
        
    end
    
    #show the detailed graph of a team for instructor
    def showATeamForInstructor
        @team = params[:team]
        iter = params[:iter]
        @tasks = StudentTask.where('iteration_id': iter, 'project_id': @team)
        #todo: diplay the tasks 
    end
end
