class CommentsController < ApplicationController
layout 'sidebar_backoffice'

  # GET /comments
  def index
    @comments = Comment.all 
  end

  # POST /comments
  def create
    @recurrence = Recurrence.find(params[:recurrence_id])
    @comment = @recurrence.comments.build(params[:comment])
    @comment.user = @current_user
    @comment.save

    redirect_to recurrence_path(@recurrence)
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back, notice: 'Comment was successfully deleted!'
  end
end
