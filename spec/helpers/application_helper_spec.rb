# encoding: utf-8
require "spec_helper"

describe ApplicationHelper do

let(:user) { FactoryGirl.create(:user, email: "john@doe.com") }
let(:recurrence) { FactoryGirl.create(:recurrence) }

  it "#comment_link"

  describe "#display_for_admin" do
    context "when the current user has the role admin" do
      it "displays the content" do
        user = stub('User', :admin? => true)
        helper.stub(:current_user).and_return(user)
        content = helper.display_for_admin {"content"}

        expect(content).to eq("content")
      end
    end

    context "when the current_user does not have the role admin" do
      it "does not display the content" do
        user = stub('User', :admin? => false)
        helper.stub(:current_user).and_return(user)
        content = helper.display_for_admin {"content"}

        expect(content).to eq(nil)
      end
    end
  end

  describe "#email_link" do
    it "should generate the link" do
      helper.email_link([user], recurrence).should match(/\<a class="icon-envelope" href="mailto:john@doe.com?(.*)body=(.*)subject=(.*)" title="(.*)"\>\<\/a\>/)
    end
  end

  it "#format_date"

  it "#2x #google_link"

end

