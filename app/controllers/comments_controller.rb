class CommentsController < ApplicationController

  # GET /comments
  def index
    @comments = Comment.all # order("created_at DESC")
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

    redirect_to :back
  end

end

