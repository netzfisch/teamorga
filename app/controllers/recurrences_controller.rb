class RecurrencesController < ApplicationController
  layout 'sidebar_default', :only => [:index, :show]

  # GET /recurrences
  def index
    @recurrences = Recurrence.current.paginate(page: params[:page], per_page: 8)
    @group = Group.first

    @birthdays = User.upcoming_birthdays
    @comments = Comment.limit(20)
  end

  # GET /recurrences/1
  def show
    @recurrence = Recurrence.find(params[:id])
  
    @accepter = @recurrence.feedback(true)
    @refuser = @recurrence.feedback(false)
    @no_replyer = @recurrence.feedback("none")

    @birthdays = User.upcoming_birthdays
    @comments = @recurrence.comments.scoped #that way lazy loaded!
  end

  # GET /recurrences/new
  def new
    @recurrence = Recurrence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recurrence }
    end
  end

  # GET /recurrences/1/edit
  def edit
    @recurrence = Recurrence.find(params[:id])
  end

  # POST /recurrences
  def create
    @recurrence = Recurrence.new(params[:recurrence])

    if @recurrence.save
      redirect_to @recurrence, notice: 'recurrence was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /recurrences/1
  def update
    @recurrence = Recurrence.find(params[:id])

    if @recurrence.update_attributes(params[:recurrence])
      redirect_to @recurrence, notice: 'recurrence was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /recurrences/1
  def destroy
    @recurrence = Recurrence.find(params[:id])
    @recurrence.destroy

    redirect_to event_path(@recurrence.event), notice: 'recurrence was successfully destroyed.'
  end
end
