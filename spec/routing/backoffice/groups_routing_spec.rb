require "spec_helper"

describe Backoffice::GroupsController do
  describe "routing" do
    it "routes to #index" do
      get("/backoffice/groups").should route_to("backoffice/groups#index")
    end

    it "routes to #new" do
      get("/backoffice/groups/new").should route_to("backoffice/groups#new")
    end

    it "routes to #show" do
      get("/backoffice/groups/1").should route_to("backoffice/groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/backoffice/groups/1/edit").should route_to("backoffice/groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/backoffice/groups").should route_to("backoffice/groups#create")
    end

    it "routes to #update" do
      put("/backoffice/groups/1").should route_to("backoffice/groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/backoffice/groups/1").should route_to("backoffice/groups#destroy", :id => "1")
    end
  end
end
