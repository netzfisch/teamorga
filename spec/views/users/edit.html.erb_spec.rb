require 'spec_helper'

describe "users/edit" do

  let(:user) { FactoryGirl.create(:user, :admin) }

  before :each do
    assign(:user, user)
    view.stub(:display_for).and_return(nil)
    render
  end

  it { should_not be_nil }
  it { should render_template("edit") }

  context "when the current user has the role 'admin'" do
    it "displays admin content" do
      view.stub(:display_for).with(:admin).and_yield
      render

      expect(rendered).to match /Admin/
    end
  end
end
