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
  end

  def create
    @batch = Batch.new(batch_params)
    @batch.user = current_user
      
    @batch.course_id = params[:batch][:course_id] if params[:batch][:course_id].present?
    @batch.comment_id = params[:batch][:comment_id] if params[:batch][:comment_id].present?
    
    if @batch.save
      current_user.batches << @batch  # Add the batch to current_user.batches
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

  # private

  def batch_params
    params.require(:batch).permit(:name, :description, :start_date, :end_date, :duration)
  end

  def get_batches
    @batches = current_user.batches
  end
  
end