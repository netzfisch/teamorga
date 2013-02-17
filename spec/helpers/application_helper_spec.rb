# encoding: utf-8
require "spec_helper"

describe ApplicationHelper do

  describe "#active_class_if(url)" do
    context "when link and actual URL are the same" do 
      it "generates an active link" do
        url = "http://example.com/"
        helper.stub(:current_page?).with("http://example.com/").and_return(true)

        helper.active_class_if(url, "link").should match(/\<li class="active"\>link\<\/li\>/)
      end
    end

    context "when link and actual URL are not the same" do 
      it "generates a passive link" do
        url = "http://example.com/"
        helper.stub(:current_page?).with("http://example.com/").and_return(false)

        helper.active_class_if(url, "link").should match(/\<li\>link\<\/li\>/)
      end
    end
  end

  it "#comment_link"

  describe "#display_for(role)" do
    let(:user) { FactoryGirl.create(:user, admin: false) }
    
    context "when the current user has the role 'admin'" do
      it "displays the content" do
        helper.stub(:current_user).and_return(stub('User', :admin? => true))
        content = helper.display_for(:admin) {"content"}

        expect(content).to eq("content")
      end
    end

    context "when the current_user has not the role 'admin'" do
      it "does not display the content" do
        helper.stub(:current_user).and_return(stub('User', :admin? => false))
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
        other_user = FactoryGirl.create(:user, admin: false)
        helper.stub(:current_user).and_return(other_user)

        helper.stub(:user).and_return(@user)
        content = helper.display_for(:owner) {"content"}

        expect(content).to eq(nil)
      end
    end
  end

  describe "#email_link" do
    let(:user) { FactoryGirl.create(:user, email: "john@doe.com") }
    let(:recurrence) { FactoryGirl.create(:recurrence) }

    it "should generate the link" do
      helper.email_link([user], recurrence).should match(/\<a class="icon-envelope" href="mailto:john@doe.com?(.*)body=(.*)subject=(.*)" title="(.*)"\>\<\/a\>/)
    end
  end

  it "#format_date"

  it "#2x #google_link"

end
