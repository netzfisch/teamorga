class EventsController < ApplicationController
layout 'sidebar_backoffice'

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

    # probably it might be sensefull to integrate the
    # creation of event and recurrences in one method?
    if @event.save
      # create associated recurrences
      @event.create_recurrences
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /events/1
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path, notice: 'Event was successfully deleted!'
  end
end

