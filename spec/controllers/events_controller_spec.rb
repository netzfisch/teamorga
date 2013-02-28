require 'spec_helper'

describe EventsController do
  let(:event)  { mock_model(Event).as_null_object }

  let(:user) { FactoryGirl.create(:user) }
  before(:each) { controller.stub(current_user: user) } # request valid session

  describe "GET index" do
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
    before(:each) { Event.stub(:new).and_return(event) }

    def do_post
      post :create
    end

    it "creates a new event" do
      Event.should_receive(:new).with("category" => "Training").and_return(event)
      post :create, event: { "category" => "Training" }
    end

    it "increments events by one" do
      expect{ do_post }.to change{ Event.count }.by(1)
    end

    # see rspec-book position 10451, should not dates_between, but Recurrence.new !???
    it 'calls the model method that finds recurrences dates of the event' do
      fake_results = ["2012-12-01", "2012-12-08", "2012-12-15"]
      event.should_receive(:dates_between).with("2012-12-01", "2012-12-15").and_return(fake_results)
    end

    context "when the event saves successfully" do
      before { event.stub(:save).and_return(true) }

      it "sets a flash[:notice] event" do
        do_post
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the Events index" do
        do_post
        response.should redirect_to(event) # oder :action => "index" ?
      end
    end

    context "when the event fails to save" do
      before { event.stub(:save).and_return(false) }

      it "assigns event" do
        do_post
        assigns[:event].should eq(event)
      end

      it "renders the new template" do
        do_post
        response.should render_template("new")
      end
    end
  end
end

