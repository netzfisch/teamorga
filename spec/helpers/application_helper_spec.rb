# encoding: utf-8
require "spec_helper"

describe ApplicationHelper do

let(:user) { FactoryGirl.create(:user, email: "john@doe.com") }
let(:recurrence) { FactoryGirl.create(:recurrence) }

  describe "#admin_link"

  describe "#comment_link"

  describe "#email_link" do
    it "should generate the link" do
      expect(helper.email_link([user], recurrence)).to eq('<a class="icon-envelope" href="mailto:john@doe.com?body=Hey%2C%0Awir%20brauchen%20mehr%20Leute%20...&amp;subject=Training%20am%2011.%20January%202013" title="eMail an aller dieser Gruppe versenden!"></a>')

      # match(Regexp.escape(/a href="mailto:john@doe.com?(.*)body=(.*)subject=(.*)">email !</a>/i)
    end
  end

  describe "2x #google_link"

end

