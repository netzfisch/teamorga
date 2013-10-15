require 'spec_helper'

describe RecurrencesController do
  # This should return the minimal set of attributes required to create a valid
  # Recurrence. As you add validations to the Recurrence model, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { scheduled_to: "2013-05-08" }
  end

  let(:recurrence) { FactoryGirl.create(:recurrence) } # Recurrence.create! valid_attributes }
  let(:user) { FactoryGirl.create(:user) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RecurrencesController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: user)
  end

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

    it "assigns all birthdays as @birthdays" do
      user.update_attributes(birthday: "2013-06-15")
      Date.stub(:current).and_return(Date.new 2013,06,15)

      get :index, {}, valid_session
      expect(assigns :birthdays).to eq([user])
    end

    it "assigns all comments as @comments" do
      recurrence.comments.create(user_id: user.id, body: "time to beach")

      get :index, {}, valid_session
      expect(assigns :comments).to match_array(recurrence.comments)
      # IMPORTANT for Rails 4, as then 'Recurrence.all' will 
      # return ActiveRecord::Relation instead of Array, see
      # https://www.relishapp.com/rspec/rspec-rails/docs/matchers/activerecord-relation-match-array
    end

    it "assigns all recurrences as @recurrences" do
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
    it "returns http success" do
      get :show, { :id => recurrence.to_param }, valid_session
      expect(response).to be_success
    end

    it "renders the 'show' template" do
      get :show, { :id => recurrence.to_param }, valid_session
      expect(response).to render_template("show")
    end

    it "assigns a recurrence as @recurrence" do
      get :show, { :id => recurrence.to_param }, valid_session
      expect(assigns :recurrence).to eq(recurrence)
    end

    it "assigns all accepter as @accepter" do
      get :show, { :id => recurrence.to_param }, valid_session
      expect(assigns :accepter).to eq(recurrence.feedback(true))
    end

    it "assigns all refuser as @refuser" do
      get :show, { :id => recurrence.to_param }, valid_session
      expect(assigns :refuser).to eq(recurrence.feedback(false))
    end

    it "assigns all no_replyer as @no_replyer" do
      get :show, { :id => recurrence.to_param }, valid_session
      expect(assigns :no_replyer).to eq(recurrence.no_feedback)
    end

    it "assigns all birthdays as @birthdays" do
      user.update_attributes(birthday: "2013-06-15")
      Date.stub(:current).and_return(Date.new 2013,06,15)

      get :show, { :id => recurrence.to_param }, valid_session
      expect(assigns :birthdays).to eq([user])
    end

    it "assigns all comments as @comments" do
      recurrence.comments.create(user_id: user.id, body: "time to beach")

      get :show, { :id => recurrence.to_param }, valid_session
      expect(assigns :comments).to match_array(recurrence.comments)
      # IMPORTANT for Rails 4, as then 'Recurrence.all' will 
      # return ActiveRecord::Relation instead of Array, see
      # https://www.relishapp.com/rspec/rspec-rails/docs/matchers/activerecord-relation-match-array
    end
  end
end
