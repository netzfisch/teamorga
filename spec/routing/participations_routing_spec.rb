require "spec_helper"

describe ParticipationsController do
  describe "routes custom actions" do
    let(:participation) { FactoryGirl.create(:participation) }

    it "routes to #create_status" do
      expect(post("/participations/#{participation.to_param}/create_status")).to route_to(controller: "participation", action: "create_status")
    end

    it "routes to #toggle_status" do
      expect(post("/participations/#{participation.to_param}/toggle_status")).to route_to(controller: "participation", action: "toggle_status")
    end
  end
end
