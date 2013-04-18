# encoding: utf-8
require "spec_helper" 

describe ApplicationHelper do

  describe "#active_class_if" do
    context "when the navigation path 'contains' the current controller" do 
      it "generates an active link" do
        helper.stub(:params).and_return({:controller => "controller_name"})

        helper.active_link_if("controller_name", "link_name", "link_path").should match(/\<li class="active"\>\<a href=\"link_path\"\>link_name\<\/a\>\<\/li\>/)
      end
    end

    context "when the navigation path 'contains' not the current controller" do 
      it "generates a passive link" do
        helper.stub(:params).and_return({:controller => "other_controller_name"})

        helper.active_link_if("controller_name", "link_name", "link_path").should match(/\<li\>\<a href=\"link_path\"\>link_name\<\/a\>\<\/li\>/)
      end
    end
  end

  describe "#markdown_parser" do
    context "when the text field contains markdown syntax for 'bold'" do
      it "generates valid html" do

        helper.markdown_parser("**bold text**").should match("<strong>bold text</strong>")
      end
    end

    context "when the text field contains markdown syntax for a 'link'" do
      it "generates valid html" do

        helper.markdown_parser("[this is a example link](http://example.com)").should match("<a href=\"http://example.com\">this is a example link</a>")
      end
    end

    context "when the text field contains just a 'link'" do
      it "generates valid html" do

        helper.markdown_parser("generates http://automatic-links.com").should match("generates <a href=\"http://automatic-links.com\">http://automatic-links.com</a>")
      end
    end
    
    context "when the text field contains a 'mention link'" do
      it "generates valid html" do

        helper.mention_link("I mention @bill ...").should match("I mention <a href=\"/users/bill\">@bill</a> ...")
      end
    end
  end

  describe "#mention_link" do
    let(:user) { FactoryGirl.create(:user, id: 8, name: "greg") }

    context "when the text field contains a user name at the beginning" do
      it "creates a  mention link" do

        helper.mention_link("@bill at the beginning").should match("<a href=\"/users/bill\">@bill</a> at the beginning")
      end
    end

    context "when the text field contains two user names" do
      it "creates two mention links" do

        helper.mention_link("here I mention @bill and @greg ...").should match("here I mention <a href=\"/users/bill\">@bill</a> and <a href=\"/users/greg\">@greg</a> ...")
      end
    end

    context "when the text field contains a email adress" do
      it "creates not a mention link" do

        helper.mention_link("and his email is greg@example.com ...").should match("and his email is greg@example.com ...")
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
