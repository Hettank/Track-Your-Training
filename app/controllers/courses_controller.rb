class CoursesController < ApplicationController
  before_action :authorize_trainer, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_one_course, only: [:show, :enroll]
  before_action :set_course, only: [:manage_trainees]

  def index
    @courses = Course.all
  end

  # Getting Specific Courses Associated to 'User'
  def my_courses
    if current_user.trainer?
      @courses = current_user.created_courses  # Shows courses the user created
    else
      @courses = current_user.enrolled_courses # Shows courses the user is enrolled in
    end
    render :index
  end

  # Handling Trainees
  # def manage_my_course_trainees
  #   # @course = current_user.created_courses.find(params[:course_id])
  #   # @trainees = @course.trainees.where(role: 'trainee')
  #   # render :manage_my_course_trainees_path
  #   @trainees = @course.trainees.where(role: 'trainee')
  # end  
  # def manage_trainees
  #   @trainees = @course.trainees.where(role: 'trainee')
  # end

  def manage_all_trainees
    @courses = current_user.created_courses.includes(:trainees)
    @all_trainees = @courses.flat_map(&:trainees)
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