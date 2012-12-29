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

  # POST /participations
  # TODO: remove - old custom create action for participation
  def create
    recurrence = Recurrence.find(params[:id])
    current_user.recurrences << recurrence

    redirect_to :back
  end

  # POST /participations#create_status
  # custom create action for participations
  def create_status
    recurrence = Recurrence.find(params[:id])
    Participation.create(recurrence: recurrence, user: current_user, status: params[:status])

    redirect_to :back
  end

  # PUT /participations/1
  # TODO: remove - old custom update action for participation
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to recurrences_path, notice: 'participation was successfully updated.'
    else
      render action: "edit"
    end
  end

  # PUT /participations/1#toggle_status
  # custom update action for participation
  def toggle_status
    participation = Participation.find(params[:id])
    participation.toggle(:status)
    participation.save

    redirect_to :back
  end

  # DELETE /participations/1
  # TODO: remove - old custom destroy action for participation
  def destroy
    recurrence = Recurrence.find(params[:id])
    recurrence.users.destroy(current_user)

    redirect_to :back
  end

end

