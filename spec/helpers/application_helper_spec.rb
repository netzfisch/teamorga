# encoding: utf-8
require "spec_helper"

describe ApplicationHelper do

let(:user) { FactoryGirl.create(:user, email: "john@doe.com") }
let(:recurrence) { FactoryGirl.create(:recurrence) }

before(:each) do
  #session.stub(user_id: user.id)
  #session.stub(:[]).with(:user_id).and_return(user.id)
  #helper.stub(current_user: @user)
end

  it "#comment_link"

  describe "#display_for(role)" do
    context "when the current user has the role 'admin'" do
      it "displays the content" do
        user = stub('User', :admin? => true)
        helper.stub(:current_user).and_return(user)
        content = helper.display_for(:admin) {"content"}

        expect(content).to eq("content")
      end
    end

    context "when the current_user has not the role 'admin'" do
      it "does not display the content" do
        user = stub('User', :admin? => false)
        helper.stub(:current_user).and_return(user)
        content = helper.display_for(:admin) {"content"}

        expect(content).to eq(nil)
      end
    end

    context "when the current user is the 'owner' or has the role 'admin'" do
      it "displays the content" do
        helper.stub(:current_user).and_return(@user)
        content = helper.display_for(:owner) {"content"}

        expect(content).to eq("content")
      end
    end

    context "when the current_user is not the 'owner' and has not the role 'admin'" do
      it "does not display the content" do
        user = FactoryGirl.create(:user, admin: false)
        current_user = FactoryGirl.create(:user, admin: false)
        helper.stub(:user).and_return(user)
        helper.stub(:current_user).and_return(current_user)
        
        content = helper.display_for(:owner) {"content"}
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

