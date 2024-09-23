class CoursesController < ApplicationController
  before_action :authorize_trainer, only: [:new, :create, :manage_all_trainees, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update]
  before_action :find_one_course, only: [:show, :enroll, :edit, :update]
  # before_action :set_course, only: [:manage_all_trainees]

  def index   
    @courses = Course.all
  end

  # Getting Specific Courses Associated to 'User'
  def my_courses
    if !current_user.present?
      redirect_to root_path 
    else
      if current_user.trainer?
        @courses = current_user.created_courses  # Shows courses the user created
      else
        @courses = current_user.enrolled_courses # Shows courses the user is enrolled in
      end
      render :index
    end
  end


  def manage_all_trainees
    @courses = current_user.created_courses.includes(:trainees)
    @all_trainees = @courses.flat_map(&:trainees).uniq
  end
  
  def enroll
    if current_user.trainee?
      enrollment = Enrollment.new(user: current_user, course: @course)

      if enrollment.save
        redirect_to course_path(@course), notice: "Successfully enrolled in the course."        
      else
        redirect_to course_path(@course), alert: "Enrollment failed."
      end

    else
      redirect_to course_path(@course), alert: "Only trainees can enroll in courses."
    end
  end

  # Cancel the enrollment
  def unenroll
    @course = Course.find_by(params[:id])

    enrollment = current_user.enrollments.find_by(course: @course)

    if enrollment
      enrollment.destroy
      redirect_to course_path(@course), notice: "Successfully unenrolled from the course."
    else
      redirect_to course_path(@course), alert: "You are not enrolled in this course."
    end
  end

  def destroy
    @course = Course.find(params[:id])
    
    if @course.destroy
      redirect_to my_courses_path, notice: "Course was deleted successfully."
    else
      redirect_to my_courses_path, alert: "Failed to delete the course."
    end
  end
  

  # Trainer can remove trainee
  def remove_trainee
    # Ensure the course belongs to the current trainer
    @course = current_user.created_courses.find_by(id: params[:id])
    if @course.nil?
      return redirect_to manage_all_trainees_path, alert: "Course not found."
    end
  
    # Find the trainee to remove from the course
    @trainee = @course.trainees.find_by(id: params[:trainee_id])
    
    if @trainee
      @course.trainees.delete(@trainee)
      redirect_to manage_all_trainees_path, notice: "Trainee removed successfully."
    else
      redirect_to manage_all_trainees_path, alert: "Trainee not found."
    end
  end  
  

  def new
    @course = Course.new
  end
  

  def create
    @course = current_user.created_courses.build(course_params())

    if @course.save
      redirect_to my_courses_path, notice: "Course Was Successfully Created"      
    else
      render :new, status: 422
    end
  end

  def show
    @course = Course.find(params[:id])
    @comment = Comment.new
    @comments = @course.comments.includes(:user).where(parent_id: nil)
  end

  def edit
  end

  def update
    if @course.update(course_params())
      redirect_to @course, notice: "Course was updated successfully"
    else 
      render :edit, alert: "Failed updating course"
    end
  end

  private
  
  def find_one_course
    @course = Course.find(params[:id])
  end

  def set_course
    @course = current_user.created_courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :duration, :category, :level, :start_date, :end_date, :prerequisites, :course_content, :instructor_bio, :course_content, :image)
  end

  def authorize_trainer
    if user_signed_in?
      unless current_user.role == 'trainer'
        redirect_to root_path, alert: "Only Trainers Can Create Courses"
      end
    end
  end
end