class CommentsController < ApplicationController
  
  def index
    @comments = Comment.find(:all, :order => 'created_at DESC', :limit => 10)
  end
  
  def create
    @recurrence = Recurrence.find(params[:recurrence_id])
    @comment = @recurrence.comments.build(params[:comment])
    @comment.user = @current_user
    @comment.save    
    
    redirect_to recurrence_path(@recurrence)
  end
  
end
