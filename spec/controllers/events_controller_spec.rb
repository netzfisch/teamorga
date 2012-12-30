require 'spec_helper'

describe EventsController do

  let(:event) { mock_model(Event).as_null_object }

  # better create helper, to write:
  #   sign_in FactoryGirl.create(:user) or
  #   FactoryGirl.create(:user, session[:user_id] = user.id)
  before(:each) do
    user = User.create!(:email => "jdoe", :password => "secret", :name => "jdoe")
    request.session = { :user_id => user.id }
  end

  describe "GET index" do
    before(:each) do
      Event.stub(:find).with(:all).and_return([event])
    end

    it "should be successfull" do
      get :index
      expect(response).to be_success
    end

    it "should assign events" do
      get :index
      expect(assigns[:events]).to be_instance_of(Array)
    end

    it "should call the find method of the event class" do
      Event.should_receive(:find).with(:all).and_return([event])
      get :index
    end

    it "should render the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST create" do
    before(:each) do
      Event.stub!(:new).and_return(event)
    end

    it "creates a new event" do
      Event.should_receive(:new).with("category" => "Training").and_return(event)
      post :create, :event => { "category" => "Training" }
    end

    # see rspec-book position 10451, should not dates_between, but Recurrence.new !???
    it 'calls the model method that finds recurrences dates of the event' do
      fake_results = ["2012-12-01", "2012-12-08", "2012-12-15"]
	    Event.should_receive(:dates_between).with("2012-12-01", "2012-12-15").and_return(fake_results)
    end

    context "when the event saves successfully" do
      before do
        event.stub(:save).and_return(true)
      end

      it "sets a flash[:notice] event" do
        post :create
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the Events index" do
        post :create
        response.should redirect_to(event) # oder :action => "index" ?
      end
    end

    context "when the event fails to save" do
      before do
        event.stub(:save).and_return(false)
      end

      it "assigns event" do
        post :create
        assigns[:event].should eq(event)
      end

      it "renders the new template" do
        post :create
        response.should render_template("new")
      end
    end
  end
end

