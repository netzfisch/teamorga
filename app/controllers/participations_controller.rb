class ParticipationsController < ApplicationController
  layout 'with_sidebar', :only => :index

  # GET /participation/index
  def index
    @participations = Participation.all
  end

  # GET /participation/1/edit
  def edit
    @user = User.find(params[:id])
    @recurrences = Recurrence.current
  end

  def update_status
    participation = Participation.find(params[:id])
    participation.toggle!(:status)
    #update_attributes(status: false)

    #participation = Participation.where("recurrence_id = ? AND user_id = ?", params[:id], current_user)
    #recurrence.participation.toggle(:status)
    #recurrence = Recurrence.find(params[:recurrence_id])
    redirect_to :back, notice: 'participation was successfully changed.'
  end

  # PUT /participations/1
  # PUT /participations/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to recurrences_path, notice: 'participation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /participations#create_status
  # custom confirm action for participation
  def create_status
    recurrence = Recurrence.find(params[:id])
    recurrence.participations.create!(user: current_user, status: params[:status])
    redirect_to :back, notice: 'participation was successfully changed.'
  end

  # POST /participations
  # custom confirm action for participation
  def create
    recurrence = Recurrence.find(params[:id])
    current_user.recurrences << recurrence
    redirect_to recurrence
  end

  # DELETE /participations/1
  # custom deny action for participation
  def destroy
    recurrence = Recurrence.find(params[:id])
    recurrence.users.destroy(current_user)
    # or, other way around - ONLY delete:
    # current_user.recurrences.delete(recurrence)
    redirect_to recurrence
    # or, long version:
    # redirect_to :controller => "recurrences", :action => "show", :id => recurrence
  end

end

