require "spec_helper"

describe PagesController do
  describe "routing" do
    it "routes '/pages/imprint' to #imprint" do
      expect(get("/pages/imprint")).to route_to("pages#imprint")
    end

    it "routes '/pages/static_page' to #statc_page" do
      expect(get("/pages/static_page")).to be_routable
      expect(get("/pages/static_page")).to route_to(:controller => "pages", :action => "static_page")
    end
  end
end
