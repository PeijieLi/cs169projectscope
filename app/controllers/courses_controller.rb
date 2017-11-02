class CoursesController < ApplicationController

	def index
        if current_user.is_instructor?
            session['project_id'] = nil
            session['iteration_id'] = nil
        end
        if current_user.is_student?
            redirect_to projects_path
        else
            session['course_id'] = nil
    		@courses = Course.where('user_id': current_user.id)
        end
    end

    def show
        session['project_id'] = nil
        session['course_id'] = params[:id]
        session['iteration_id'] = nil
        redirect_to projects_path 'course_id': session['course_id']
    end

    def create
    	new_course = Course.new
    	info = params[:course]
        new_course.coursename=info['coursename']
        new_course.user_id = current_user.id
        new_course.save!
    	redirect_to courses_path
    end
end
