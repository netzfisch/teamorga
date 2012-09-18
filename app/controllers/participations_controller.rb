class ParticipationsController < ApplicationController
  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.all
    #(
     # :order => :scheduled_to, 
      #:conditions => { :scheduled_to => (Date.today - 1.week)..(Date.today + 5.weeks) }
      #)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participation }
    end
  end

  def new
  end

  def show
  end

  # GET /participation/1/edit
  def edit
    @user = User.find(params[:id])
  end
end
