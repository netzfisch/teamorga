require 'spec_helper'

describe RecurrencesController do

# TODO check spec/views/recurrences/index.html.rb_spec for **mocking will_paginate** and check also
# http://codereview.stackexchange.com/questions/505/how-to-effectively-unit-test-a-controller-in-ruby-on-rails-please-critique-a-sa

  # This should return the minimal set of attributes required to create a valid
  # Recurrence. As you add validations to the Recurrence model, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    #{ event_id: FactoryGirl.create(:event).id, scheduled_to: "2013-05-08" }
    { scheduled_to: "2013-05-08" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RecurrencesController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: FactoryGirl.create(:user))
    # alternatively { session[:user_id] = user.id } or {:user_id => user.id} 
  end

  let(:recurrence) { Recurrence.create! valid_attributes }

  describe "GET index" do
    before(:each) { Recurrence.stub_chain(:current, :paginate).and_return([recurrence]) }
    
    it "returns http success" do
      get :index, {}, valid_session
      expect(response).to be_success
    end

    it "renders the 'index' template" do
      get :index, {}, valid_session
      expect(response).to render_template("index")
    end

    it "assigns all groups as @groups" do
      group = Group.create!(private_information: "Next workout will be at ...")
      get :index, {}, valid_session
      expect(assigns :groups).to eq([group])
    end

    it "assigns all birthdays as @birthdays" do
      Date.stub!(:current).and_return(Date.new 2013,06,15)
      user = FactoryGirl.create(:user, birthday: "2013-06-15")
      get :index, {}, valid_session
      expect(assigns :birthdays).to eq([user])
    end

    it "assigns all comments as @comments" do
      comment = Comment.create!(body: "time to beach")
      get :index, {}, valid_session
      expect(assigns :comments).to eq([comment])
    end

    it "assigns all recurrences as @recurrences" do
      #recurrence = Recurrence.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns :recurrences).to eq([recurrence])
    end

    it "calls the paginate method on all recurrences" do
      Recurrence.current.should_receive(:paginate).and_return([@recurrence])
      get :index, {}, valid_session
    end

    it "passes the page number on to will_paginate" do
      Recurrence.current.should_receive(:paginate).with(page: "3", per_page: 8).and_return(recurrence)
      get :index, { page: "3" }, valid_session
    end

    it "returns eight results per page" do
      Recurrence.current.should_receive(:paginate).with(page: nil, per_page: 8).and_return(recurrence)
      get :index, {}, valid_session
    end
  end

  describe "GET show" do
    it "returns http success"

    it "assigns a recurrence as @recurrence"

    it "assigns all accepter as @accepter"

    it "assigns all refuser as @refuser"

    it "assigns all no_replyer as @no_replyer"

    it "assigns all comments as @comments" do
      comment = Comment.create!(body: "time to beach")
      get :index, {}, valid_session
      expect(assigns :comments).to eq([comment])
    end

    it "reners the 'show' template"
  end
end
