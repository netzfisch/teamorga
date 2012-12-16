require 'spec_helper'

describe ParticipationsController do
  describe "GET index" do

    before(:each) do
      # better create helper, to write:
      #   sign_in FactoryGirl.create(:user) or
      #   FactoryGirl.create(:user, session[:user_id] = user.id)
      user = User.create!(:email => "jdoe", :password => "secret", :name => "jdoe")
      session[:user_id] = user.id

      @participation = mock_model(Participation)
      Participation.stub(:find).with(:all).and_return([@participation])
    end

    it "should be successfull" do
      get :index
      expect(response).to be_success
    end

    it "should assign an array of participations" do
      get :index
      expect(assigns[:participations]).to be_instance_of(Array)
    end

    it "should call the find method of the participation class" do
      Participation.should_receive(:find).with(:all).and_return(@participation)
      get :index
    end

    it "should render the index template" do
      get :index
      expect(response).to render_template("index")
    end

  end
end

