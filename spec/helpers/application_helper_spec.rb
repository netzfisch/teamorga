# encoding: utf-8
require "spec_helper"

describe ApplicationHelper do

let(:user) { FactoryGirl.create(:user, email: "john@doe.com") }
let(:recurrence) { FactoryGirl.create(:recurrence) }

  describe "#admin_link"

  describe "#email_link" do
    it "should generate the link" do
      expect(helper.email_link([user], recurrence)).to match(Regexp.escape(/a href="mailto:john@doe.com?(.*)body=(.*)subject=(.*)">email !</a>/i)
    end
  end

<i class="icon-envelope"></i>


  describe "#google_link"

end

