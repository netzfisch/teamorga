class RecurrencesController < ApplicationController
  layout 'with_sidebar', :only => [:index, :index_old, :show]

  # GET /recurrences
  def index
    @recurrences = Recurrence.current.paginate(page: params[:page], per_page: 8)
    @comments = Comment.order("created_at DESC").limit(5)
  end

  def index_old
    @users = User.all
    @recurrences = Recurrence.current.paginate(page: params[:page], per_page: 5)
    @comments = Comment.order("created_at DESC").limit(5)
  end

  # GET /recurrences/1
  def show
    @recurrence = Recurrence.find(params[:id])

    # which way makes sense, is faster?
    @accepter = @recurrence.participations.accepted.map(&:user)
    #@accepter = Participation.feedback(@recurrence, true)
    @refuser = Participation.feedback(@recurrence, false) # @refuser = @recurrence.feedback(@recurrence, false)
    #@refuser = @recurrence.participations.refused.map(&:user)

    @comments = @recurrence.comments.order("created_at DESC").limit(5)
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

    redirect_to events_path, notice: 'recurrence was successfully destroyed.'
  end

end

