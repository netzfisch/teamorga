require 'spec_helper'

describe "users/edit" do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before :each do
    assign(:user, user)
    view.stub(:display_for).and_return(nil)
    render
  end

  it { should_not be_nil }
  it { should render_template("edit") }

  context "when the current user has NOT the role 'admin'" do
    it "displays not the admin content" do
      expect(rendered).not_to match /Admin/
    end
  end

  context "when the current user has the role 'admin'" do
    it "displays the admin content" do
      assign(:user, admin)
      view.stub(:display_for).with(:admin).and_yield
      render

      expect(rendered).to match /Admin/
    end
  end
end
