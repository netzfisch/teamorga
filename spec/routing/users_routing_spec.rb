require "spec_helper"

describe UsersController do
  describe "routes friendlyID slug" do
    it "routes to users#name" do
      expect(get("/users/joe")).to route_to(controller: "users", action: "show", id: "joe")
    end
  end
end
