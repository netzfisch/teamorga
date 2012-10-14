class CommentsController < ApplicationController

  # GET /comments
  # GET /comments.json 
  def index
    @comments = Comment.find(:all, :order => 'created_at DESC', :limit => 10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }    
    end
  end

  # POST /comments
  # POST /comments.json 
  def create
    @recurrence = Recurrence.find(params[:recurrence_id])
    @comment = @recurrence.comments.build(params[:comment])
    @comment.user = @current_user
    @comment.save    
    
    redirect_to recurrence_path(@recurrence)
  end  
  
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

end
