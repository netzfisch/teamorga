require 'spec_helper'

describe EventsController do
  describe "POST create" do
    let(:event) { mock_model(Event).as_null_object }

    before(:each) do
      user = User.create!(:email => "jdoe", :password => "secret", :name => "jdoe")
      request.session = { :user_id => user.id }
      Event.stub(:new).and_return(event)
    end

    it "creates a new event" do
      Event.should_receive(:new).with("category" => "Training").and_return(event)
      post :create, :event => { "category" => "Training" }
    end

    it 'should call the model method that finds recurrences dates of the event' do
      fake_results = ["2012-12-01", "2012-12-08", "2012-12-15"]
	    event.should_receive(:dates_between).with("2012-12-01", "2012-12-15").and_return(fake_results)
    end

    context "when the event saves successfully" do
      before do
        event.stub(:save).and_return(true)
      end

      it "sets a flash[:notice] event" do
        post :create
        flash[:notice].should eq("Event was successfully created.")
        # change to new syntax: expect(flash[:notice]).to
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

      it "assigns @event" do
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

