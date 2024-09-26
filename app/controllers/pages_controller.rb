class PagesController < ApplicationController
  def home
  end

  def profile
    @user_profile = User.all
  end

  def manage_trainers
    if current_user.admin?
      @trainers = User.where(role: 'trainer')
    else
      @trainers = []
    end
  end

  def manage_trainees
    if current_user.admin?
      @trainees = User.where(role: 'trainee')
    else
      @trainees = []
    end
  end

  def destroy_trainee
    if current_user.admin?
      @trainee = User.find_by(id: params[:trainee_id])

      if @trainee.present?
        if @trainee.destroy
          redirect_to manage_trainees_path, notice: 'Trainer has been successfully deleted.'
        else
          redirect_to manage_trainees_path, alert: 'Failed to delete trainee.' 
        end
      else
        redirect_to manage_trainees_path, alert: 'Trainee not found.'
      end
    end
  end

  def destroy_trainer
    if current_user.admin?
      @trainer = User.find_by(id: params[:trainer_id])

      
      # binding.pry
      

      if @trainer.present?
        if @trainer.destroy
          redirect_to manage_trainers_path, notice: 'Trainer has been successfully deleted.'
        else
          redirect_to manage_trainers_path, alert: 'Failed to delete trainer.'
        end
      else
        redirect_to manage_trainers_path, alert: 'Trainer not found.'
      end
    end
  end
end
