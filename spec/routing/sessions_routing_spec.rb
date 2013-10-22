require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes '/login' to #new" do
      expect(get("/login")).to route_to("sessions#new")
    end

    it "routes '/logout' to #destroy" do
      expect(delete("/logout")).to route_to("sessions#destroy")
    end
  end
end
