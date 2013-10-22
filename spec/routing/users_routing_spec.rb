require "spec_helper"

describe UsersController do
  describe "routing" do
    it "routes '/signup' to #new" do
      expect(get("/signup")).to route_to("users#new")
    end

    it "routes '/users/slug' to #slug" do
      expect(get("/users/joe")).to route_to(controller: "users", action: "show", id: "joe")
    end
  end
end
