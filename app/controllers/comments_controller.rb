class CommentsController < ApplicationController
  before_action :set_course
  before_action :authenticate_user!

  def create
    if current_user.nil?
      redirect_to courses_path, alert: 'You must be logged in to comment'
      return
    end
  
    @comment = @course.comments.new(comment_params)
    @comment.user = current_user
    @comment.parent_id = params[:parent_id] if params[:parent_id]
  
    if @comment.save
      redirect_to course_path(@course)
    else
      redirect_to course_path(@course)
    end
  end
  

  def edit
    @comment = current_user.comments.find(params[:id])
    @course = @comment.course
  end

  def update
    @comment = current_user.comments.find(params[:id])
  
    if @comment.update(comment_params)
      redirect_to @course, notice: 'Comment was successfully updated.'
    else
      # Reload the course and comments if validation fails
      @course = @comment.course
      @edit_comment = @comment
      render 'courses/show' # Render the 'show' view with the necessary data
    end
  end
  

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    redirect_to course_path(@comment.course)
  end

  private
  def set_course
    @course = Course.find(params[:course_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end