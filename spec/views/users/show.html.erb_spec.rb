require 'spec_helper'

describe "users/show" do

  let(:user) { FactoryGirl.create(:user, :admin) }

  before :each do
    assign(:user, user)
    view.stub(:display_for).and_return(nil)
    render
  end

  it { should_not be_nil }
  it { should render_template("show") }

  context "when the current user has the role 'admin'" do
    it "displays admin content" do
      view.stub(:display_for).with(:admin).and_yield
      render

      expect(rendered).to match /Administrator:/
    end
  end

  context "when the current user has the role 'owner'" do
    it "should have a EDIT link" do
      view.stub(:display_for).with(:owner).and_yield
      render

      expect(rendered).to have_link("Edit", href: edit_user_path(user) )
    end

    it "should have a DESTROY link" do
      view.stub(:display_for).with(:owner).and_yield
      render

      expect(rendered).to have_link("Destroy")
    end
  end
end
