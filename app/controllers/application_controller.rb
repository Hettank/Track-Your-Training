class ApplicationController < ActionController::Base
  before_action :load_trainer_courses, if: :trainer_signed_in?

  private

  def load_trainer_courses
    @trainer_courses = current_user.created_courses if current_user&.trainer?
  end

  def trainer_signed_in?
    user_signed_in? && current_user.trainer?
  end
end
