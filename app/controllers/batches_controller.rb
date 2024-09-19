class BatchesController < ApplicationController
  before_action :authenticate_user! 
  before_action :get_batches, only: [:index, :show]
  
  def index
  end

  def new
    @batch = Batch.new
    @courses = current_user.created_courses
  end

  def show
    @batch = Batch.find(params[:id])
    @trainees = @batch.course.trainees
  end
  

  def create
    @batch = Batch.new(batch_params)
    @batch.user = current_user
      
    @batch.course_id = params[:batch][:course_id] if params[:batch][:course_id].present?
    @batch.comment_id = params[:batch][:comment_id] if params[:batch][:comment_id].present?
    
    if @batch.save
      current_user.batches << @batch
      redirect_to batches_path, notice: 'Batch was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit
  end
  
  def update
  end

  def destroy
  end

  def add_trainee
    @batch = Batch.find(params[:id])
    trainee_ids = params[:batch] ? params[:batch][:trainee_ids] : []
  
    if trainee_ids.present?
      trainees = User.where(id: trainee_ids)
      @batch.users << trainees
      redirect_to @batch, notice: 'Trainees were successfully added.'
    else
      redirect_to @batch, alert: 'No trainees selected.'
    end
  end
  

  # private

  def batch_params
    params.require(:batch).permit(:name, :description, :start_date, :end_date, :duration)
  end

  def get_batches
    @batches = current_user.batches
  end
  
end