class TasksController < ApplicationController
  before_action :set_batch, only: [:new, :create]
  before_action :set_task, only: [:show, :update_status]

  def new
    @task = Task.new
    @trainees = @batch.users.show_trainees 
  end

  def index
    if current_user.trainee?
      @assigned_tasks = current_user.tasks.filter_tasks(2)
    else
      redirect_to root_path, alert: 'failed'
    end
  end

  def show
  end

  def create
    @task = @batch.tasks.build(task_params)
    @task.trainer = current_user

    if @task.save
      redirect_to batch_path(@batch), notice: "Task has been assigned successfully"
    else
      render :new, alert: "Failed to create a task"
    end
  end

  def update_status
    if current_user.trainee? && @task.update(task_status_params)
      if @task.status.to_i == 2
        redirect_to tasks_assigned_path, notice: 'Task status updated successfully'
      else
        redirect_to batch_task_path(@task.batch, @task), notice: 'Task status updated successfully'
      end
    else
      redirect_to batch_task_path(@task.batch, @task), alert: 'Failed to update task status'
    end
  end

  def track_tasks
    @batch = Batch.find(params[:batch_id])

    if current_user.trainer?
      @trainee_tasks = @batch.tasks.includes(:trainee)
    else
      redirect_to root_path, alert: 'Access denied'
    end
  end

  private

  def set_batch
    @batch = Batch.find(params[:batch_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_status_params
    params.require(:task).permit(:status)
  end

  def task_params
    params.require(:task).permit(:name, :description, :deadline, :status, :user_id, :trainer_id)
  end
end
