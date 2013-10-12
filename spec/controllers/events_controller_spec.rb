require 'spec_helper'

describe EventsController do

  # This should return the minimal set of attributes required to create a valid
  # Event. As you add validations to the Event model, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { category: "Spieltag", base_date: "2013-05-08", end_date: "2013-05-13", place: "Hamburg" }
# TODO EventsController needs 'end_date', obviously not nil-safe! 
# TODO Move 'EventRecurrence' create action to RecurrenceModel!
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EventsController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: FactoryGirl.create(:user))
  end

  let(:event) { Event.create! valid_attributes }

  it "renders the 'backoffice' layout" do
    get :index, {}, valid_session
    expect(response).to render_template("layouts/sidebar_backoffice")
  end

  describe "GET index" do
    it "returns http success" do
      get :index, {}, valid_session
      expect(response).to be_success
    end

    it "renders the 'index' template" do
      get :index, {}, valid_session
      expect(response).to render_template("index")
    end

    it "assigns all events as @events" do
      event = Event.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns :events).to eq([event])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {id: event}, valid_session
      expect(response).to be_success
    end

    it "renders the 'show' template" do
      get :show, {id: event}, valid_session
      expect(response).to render_template :show
    end

    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :show, {:id => event.to_param}, valid_session
      assigns(:event).should eq(event)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, {}, valid_session
      expect(response).to be_success
    end

    it "renders the 'new' template" do
      get :new, {}, valid_session
      expect(response).to render_template :new
    end

    it "assigns a new event as @event" do
      get :new, {}, valid_session
      assigns(:event).should be_a_new(Event)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: event.to_param}, valid_session
      expect(response).to be_success
    end

    it "renders the 'edit' template" do
      get :edit, {id: event.to_param}, valid_session
      expect(response).to render_template :edit
    end

    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :edit, {id: event.to_param}, valid_session
      assigns(:event).should eq(event)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, {:event => valid_attributes}, valid_session
        }.to change(Event, :count).by(1)
      end

      it "calls 'dates_between' method with two date arguments" do
        Event.any_instance.should_receive(:dates_between).with(Date.new(2013,5,8), Date.new(2013,5,13)).and_return(["2013-05-08"])
        post :create, {event: valid_attributes}, valid_session
      end

      it "assigns a newly created event as @event" do
        post :create, {:event => valid_attributes}, valid_session
        assigns(:event).should be_a(Event)
        assigns(:event).should be_persisted
      end

      it "sets a flash notice about the successful created event" do
        post :create, {:event => valid_attributes}, valid_session
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the created event" do
        post :create, {:event => valid_attributes}, valid_session
        expect(response).to redirect_to(event_path(Event.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => { }}, valid_session
        assigns(:event).should be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => { }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates the requested event" do
        #event = Event.create! valid_attributes
        # Assuming there are no other events in the database, this
        # specifies that the Event created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Event.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => event.to_param, :event => { "these" => "params" }}, valid_session
      end

      it "assigns the requested event as @event" do
        #event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
        assigns(:event).should eq(event)
      end

      it "sets a flash notice about the successful updated event" do
        #event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the updated event" do
        #event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
        response.should redirect_to(event_path(event))
      end
    end

    context "with invalid params" do
      it "assigns the event as @event" do
        event = Event.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => { }}, valid_session
        assigns(:event).should eq(event)
      end

      it "re-renders the 'edit' template" do
        event = Event.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => { }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect {
        delete :destroy, {:id => event.to_param}, valid_session
      }.to change(Event, :count).by(-1)
    end

    it "sets a flash notice about the successful destroyed event" do
      event = Event.create! valid_attributes
      delete :destroy, {:id => event.to_param}, valid_session
      expect(flash[:notice]).not_to be(nil)
    end

    it "redirects to the events list" do
      event = Event.create! valid_attributes
      delete :destroy, {:id => event.to_param}, valid_session
      response.should redirect_to(events_path)
    end
  end
end
