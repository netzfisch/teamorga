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
    def do_post(status = false)
      post :create_status, id: recurrence.id, status: status
    end

    it "should respond with http status 302 (redirection found)" do
      do_post
      expect(response.status).to be(302) # better: be(201)
    end

    it "should find the recurrence" do
      Recurrence.should_receive(:find).with(recurrence.id.to_s).and_return(recurrence)
      do_post
    end

    it "should create a new participation" do
      expect { do_post }.to change { Participation.count }.by(1)
    end

    it "should set participation.status to 'true'" do
      Participation.should_receive(:create).with(hash_including(recurrence: recurrence, user: user, status: true)).and_return(participation)
      do_post(true)
    end

    it "should set participation.status to 'false'" do
      Participation.should_receive(:create).with(hash_including(recurrence: recurrence, user: user, status: false)).and_return(participation)
      do_post
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

    it "should respond with http status 302 (redirection found)" do
      do_put
      expect(response.status).to be(302)
    end

    it "should find the participation" do
      Participation.should_receive(:find).with(participation.id.to_s).and_return(participation)
      do_put
    end

    it "should toggle participation.status" do
      Participation.stub(:find).and_return(participation)

      participation.should_receive(:toggle).with(:status).and_return(true)
      do_put
    end

    it "should toggle participation.status to 'true'" do
      participation.update_attributes(status: false)
      do_put
      participation.reload
      expect(participation.status).to eq(true)
    end

    it "should toggle participation.status to 'false'" do
      participation.update_attributes(status: true)
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

