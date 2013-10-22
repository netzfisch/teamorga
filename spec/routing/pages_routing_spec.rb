require "spec_helper"

describe PagesController do
  describe "routing" do
    it "routes '/imprint' to #imprint" do
      expect(get("/imprint")).to route_to("pages#imprint")
    end

    it "routes '/static_page' to #statc_page" do
      expect(get("/static_page")).to be_routable
      expect(get("/static_page")).to route_to(:controller => "pages", :action => "static_page")
    end
  end
end
