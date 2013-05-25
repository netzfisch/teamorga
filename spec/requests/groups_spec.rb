require 'spec_helper'

describe "Backoffice::Groups" do
  describe "GET /backoffice/groups" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get backoffice_groups_path
      response.status.should be(302) # better '200'
    end
  end
end
