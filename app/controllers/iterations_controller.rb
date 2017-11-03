class IterationsController < ApplicationController

    def abandon
        @iteration = Iteration.find(params[:id])
        if session['dying_tasks'] == nil
            session['dying_tasks'] = []
        else
            to_delete = session['dying_tasks'].uniq.reject {|t| Task.find(t.to_i).iteration_id != @iteration.id}
            to_delete.each do |d|
                session['dying_tasks'].delete(d)
            end
        end

        # abandon any modification (not creation nor deletion)
        if session['task_updates'].size != 0
            to_abandon = session['task_updates'].keys.reject {|t| Task.find(t.to_i).iteration_id != @iteration.id}
            to_abandon.each do |d|
                session['task_updates'].delete(d)
            end
        end
        redirect_to iteration_path(id: params[:id])
    end

    def release
        @iteration = Iteration.find(params[:id])
        @iteration.release_at = Time.now
        @iteration.save
        flash[:message] = "Successfully published iteration!"
        if session['task_updates'].size != 0
            to_abandon = session['task_updates'].keys.reject {|t| Task.find(t.to_i).iteration_id != @iteration.id}
            to_abandon.each do |d|
                updates = session['task_updates'][d]
                Task.find(d.to_i).update_attributes!(updates)
                session['task_updates'].delete(d)
            end
        end

        if session['dying_tasks'] == nil
            session['dying_tasks'] = []
        else
            to_delete = session['dying_tasks'].uniq.reject {|t| Task.find(t.to_i).iteration_id != @iteration.id}
            to_delete.each do |d|
                session['dying_tasks'].delete(d)
                Task.find(d.to_i).destroy
            end
        end
        redirect_to iteration_path(id: params[:id])
    end

	def index
        session['iteration_id'] = nil
        if current_user.is_instructor?
            session['project_id'] = nil
        end
		@iterations = Iteration.order(id: :asc).reverse_order.limit(10)
	end

	def new
	end

	def edit
    	@curr_iter = Iteration.find(params[:id])
    end

    def destroy
    	Iteration.find(params[:id]).destroy
    	redirect_to course_path(id: session['course_id'])
	end

	def show
        # gsgs
        if current_user.is_instructor?
            session['project_id'] = nil
        end
        session['iteration_id'] = params[:id]
		@current_iteration = Iteration.find(params[:id])
		@tasks = @current_iteration.get_all_tasks_in_iteration
        @student_tasks = @tasks.reject {|t| t.created_at > @current_iteration.release_at}
        @user = current_user
        @all_projects = Project.where(course_id: session['course_id'])
        # gesgesg
	end

	def create
    	new_iter = Iteration.new
    	info = params[:iteration]
        new_iter.name=info['name']
        new_iter.course_id = session['course_id']
        new_iter.release_at = Time.now
        new_iter.start = Date.new(info["start(1i)"].to_i, info["start(2i)"].to_i, info["start(3i)"].to_i)
        new_iter.end = Date.new(info["end(1i)"].to_i, info["end(2i)"].to_i, info["end(3i)"].to_i)
        new_iter.save!
    	redirect_to projects_path()
    end

    def update
    	#retreive form submission paramaters from the total paramaters
    	iteration_params = params["iteration"]
    	to_sub = {} #this is the new array we will pass to Iteration to create a new iteration
    	to_sub["name"] = iteration_params["name"]
        to_sub["start"] = Date.new(iteration_params["start(1i)"].to_i, iteration_params["start(2i)"].to_i, iteration_params["start(3i)"].to_i)
        to_sub["end"] = Date.new(iteration_params["end(1i)"].to_i, iteration_params["end(2i)"].to_i, iteration_params["end(3i)"].to_i)
    	#We need to make a single date object from the three string objects that iteration_params contains
    	# to_sub["start"] = Date.new(iteration_params["start(1i)"].to_i, iteration_params["start(2i)"].to_i, iteration_params["start(3i)"].to_i)
    	# to_sub["end"] = Date.new(iteration_params["end(1i)"].to_i, iteration_params["end(2i)"].to_i, iteration_params["end(3i)"].to_i)
    	@iteration = Iteration.find params[:id]
    	@iteration.update_attributes!(to_sub)
    	redirect_to projects_path()
    end

	# #create a new, default Iteration and redirect to the edit page for that iteration
	# def create
	# require "date"
 #    n = Iteration.create!(:name => "new_iteration", :start => Date.today, :end => Date.today + 7)
 #    redirect_to edit_iteration_path(n.id)
  # end
end
