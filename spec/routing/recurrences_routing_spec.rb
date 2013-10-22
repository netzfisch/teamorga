require "spec_helper"

describe RecurrencesController do
  describe "routing" do
    it "routes '/' to #index" do
      expect(get("/")).to route_to("recurrences#index")
    end
  end
end
