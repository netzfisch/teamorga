require 'spec_helper'

describe RecurrencesController, "GET index" do

# REFACTOR, beautyfy and maybe change to shoulda gem, see http://codereview.stackexchange.com/questions/505/how-to-effectively-unit-test-a-controller-in-ruby-on-rails-please-critique-a-sa

    let(:recurrence) { [mock_model(Recurrence)] }

    before :each do
      user = User.create!(:email => "jdoe", :password => "secret", :name => "jdoe")
      request.session = { :user_id => user.id } # alternatively "session[:user_id] = user.id
      #@recurrence = mock_model(Recurrence)

      Recurrence.stub_chain(:visible, :paginate).and_return([@recurrence])
      # with "find.all": Recurrence.stub!(:find).with(:all).and_return([@recurrence])
    end

    it "should assign an array of recurrences" do
      get :index
      assigns[:recurrences].should be_instance_of(Array)
      expect(assigns(:recurrences)).to eq([@recurrence])
    end

    it "should be successfull" do
      get :index
      response.should be_success
    end

    it "should render the index template" do
      get :index
      response.should render_template("index")
    end

    it "should call the paginate method of the recurrence class" do
      Recurrence.visible.should_receive(:paginate).and_return(@recurrence)
      get :index
    end

    it "should defaults showing 5 results per page" do
      Recurrence.visible.should_receive(:paginate).with(:page => nil, :per_page => 5).and_return(@recurrence)
      get :index
    end

    it "should pass on the page number to will_paginate" do
      Recurrence.visible.should_receive(:paginate).with(:page => '3', :per_page => 5).and_return(@recurrence)
      get :index, 'page' => '3'
    end

end

