require "spec_helper"

describe PagesController do
  describe "routes for static pages" do
    it "routes to #imprint" do
      expect(get("/imprint")).to route_to("pages#imprint")
    end

    it "routes to random #new_page" do
      expect(get("/new_page")).to be_routable
      expect(get("/new_page")).to route_to(:controller => "pages", :action => "new_page")
    end
  end
end
