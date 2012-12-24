require 'spec_helper'

describe RecurrencesController do
  describe "GET index" do

# REFACTOR, beautyfy and maybe change to shoulda gem, see http://codereview.stackexchange.com/questions/505/how-to-effectively-unit-test-a-controller-in-ruby-on-rails-please-critique-a-sa

    let(:recurrence) { [mock_model(Recurrence)] }

    before(:each) do
      user = User.create!(:email => "jdoe", :password => "secret", :name => "jdoe")
      request.session = { :user_id => user.id } # alternatively "session[:user_id] = user.id""

      #@recurrence = mock_model(Recurrence)
      Recurrence.stub_chain(:current, :paginate).and_return([@recurrence])
    end

    it "should be successfull" do
      get :index
      response.should be_success
    end

    it "should assign an array of recurrences" do
      get :index
      assigns[:recurrences].should be_instance_of(Array)
      expect(assigns(:recurrences)).to be_instance_of(Array)
    end

    it "should call the paginate method of the recurrence class" do
      Recurrence.current.should_receive(:paginate).and_return([@recurrence])
      get :index
    end

    it "should render the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "should show five results per page" do
      Recurrence.current.should_receive(:paginate).with(:page => nil, :per_page => 5).and_return(@recurrence)
      get :index
    end

    it "should pass on the page number to will_paginate" do
      Recurrence.current.should_receive(:paginate).with(:page => '3', :per_page => 5).and_return(@recurrence)
      get :index, 'page' => '3'
    end
  end

  describe "POST #add_user" do
    let(:user) { FactoryGirl.create(:user, email: "asdf") }
    let(:recurrence) { FactoryGirl.create(:recurrence) }
    let(:participation) { FactoryGirl.create(:participation, status: false) }

    before(:each) do
      controller.stub(current_user: user)
      post :add_user, id: recurrence.id
    end

    it "should add participation feedback" do
      expect { post :add_user, id: recurrence.id }.to change { Participation.count }.by(1)
    end

    it "should accept participation for the recurrence" do
      post :add_user, id: recurrence.id, status: true
      expect(participation.status).to eq(true)
    end

    it "should refuse participation for the recurrence" do
      post :add_user, id: recurrence.id, status: false
      expect(participation.status).to eq(false)
    end

    it "should redirect to the recurrence" do
      expect(response).to redirect_to(recurrence)
    end

    it "should set a flash[:notice]" do
      expect(flash[:notice]).not_to be(nil)
    end
  end

end

