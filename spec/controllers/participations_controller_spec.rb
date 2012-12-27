require 'spec_helper'

describe ParticipationsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:recurrence) { FactoryGirl.create(:recurrence) }
  let(:participation) { FactoryGirl.create(:participation) }

  before(:each) do
    controller.stub(current_user: user)
    request.env["HTTP_REFERER"] = "http://test.host"
  end

  describe "POST create_status" do
    def do_post
      post :create_status, id: recurrence.id
    end

    it "should respond with http-status 302" do
      do_post
      expect(response.status).to be(302) # better: be(201)
    end

    it "should create a new participation" do
      expect { do_post }.to change { Participation.count }.by(1)
    end

    it "should set participation.status to 'true'" do
      Participation.should_receive(:create).with(recurrence: recurrence, user: user, status: true).and_return(participation)
      post :create_status, id: recurrence, status: true
    end

    it "should set participation.status to 'false'" do
      Participation.should_receive(:create).with(recurrence: recurrence, user: user, status: false).and_return(participation)
      post :create_status, id: recurrence, status: false
    end

    it "should redirect to the recurrence" do
      do_post
      expect(response).to redirect_to(:back)
    end

    it "should set a flash[:notice]" do
      do_post
      expect(flash[:notice]).not_to be(nil)
    end
  end

  describe "PUT toggle_status" do
    def do_put
      put :toggle_status, id: participation.id
    end

    it "should respond with http-status 302" do
      do_put
      expect(response.status).to be(302)
    end

    it "should toggle participation.status to 'true'" do
      participation.status = false; participation.save
      do_put
      participation.reload
      expect(participation.status).to eq(true)
    end

    it "neu" do
      Participation.should_receive(:toggle).with(:status).and_return(true)
      put :toggle_status, id: participation.id
    end

    it "should toggle participation.status to 'false'" do
      participation.status = true; participation.save
      do_put
      participation.reload
      expect(participation.status).to eq(false)
    end

    it "should redirect to the recurrence" do
      do_put
      expect(response).to redirect_to(:back)
    end

    it "should set a flash[:notice]" do
      do_put
      expect(flash[:notice]).not_to be(nil)
    end
  end

end

