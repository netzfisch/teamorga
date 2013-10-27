require "spec_helper"

describe GroupsController do
  describe "routing" do
    it "routes to #show" do
      get("/groups/1").should route_to("groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/groups/1/edit").should route_to("groups#edit", :id => "1")
    end

    it "routes to #update" do
      put("/groups/1").should route_to("groups#update", :id => "1")
    end
  end
end
