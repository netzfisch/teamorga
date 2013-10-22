require "spec_helper"

describe ParticipationsController do
  describe "routing" do
    let(:participation) { FactoryGirl.create(:participation) }

    it "routes to #create_status" do
      expect(post("/participations/#{participation.to_param}/create_status")).to route_to(controller: "participations", action: "create_status", id: participation.to_param)
#     expect(post("/participations")).to route_to("/participations#create_status") # classic update action
    end

    it "routes to #toggle_status" do
      expect(put("/participations/#{participation.to_param}/toggle_status")).to route_to("participations#toggle_status", id: participation.to_param)
    end
  end
end
