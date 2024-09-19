class TasksController < ApplicationController
  before_action :set_batch, only: [:new, :create]

  def new
    @task = Task.new
    @trainees = @batch.users.show_trainees 
  end

  def index
  end

  def show
  end

  def create
    
    # binding.pry 
    
    @task = @batch.tasks.build(task_params)
    @task.trainer = current_user
  
    if @task.save
      redirect_to batch_path(@batch), notice: "Task has been assigned successfully"
    else
      render :new, alert: "Failed to create a task"
    end
  end
  

  private

  def set_batch
    @batch = Batch.find(params[:batch_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :deadline)
  end
end
