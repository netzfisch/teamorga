require "spec_helper"

describe RecurrencesController do
  describe "routes the root of the site" do
    it "routes to recurrences#index" do
      expect(get("/")).to route_to("recurrences#index")
    end
  end
end
