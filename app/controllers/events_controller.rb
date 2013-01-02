class EventsController < ApplicationController

  # GET /events
  def index
    @events = Event.find(:all)
  end

  # GET /events/1
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    @event = Event.new(params[:event])

    if @event.save
    # create and save associated data to recurrences table
    # first create an array of single reoccurence dates
    # than save reoccurence dates as scheduled_to in recurrences table
# better move to recurrence controller?/model!
    for date in Event.dates_between(@event.base_date, @event.end_date)
      r = Recurrence.new       # before called with (params[:recurrence]), häh?
      r.event_id = @event.id   # specific, not unspecific like: r.event = @event
      r.scheduled_to = date
      r.save
    end
# shorter, but needs to set in recurrence-model:
#   attr_accessible :event_id
#
#   interval.each {|i| Recurrence.create(:event_id => @event.id, :scheduled_to => i) }
#   puts "*****************DBUGGING*****************", r.inspect
#
# alternatively merge params hash: p = params[:recurrence].merge(@event.id, date)

      # redirect and notice about sucessfull creation
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /events/1
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

end

