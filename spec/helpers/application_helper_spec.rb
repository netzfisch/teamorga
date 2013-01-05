# encoding: utf-8
require "spec_helper"

describe ApplicationHelper do

let(:user) { FactoryGirl.create(:user, email: "john@doe.com") }
let(:recurrence) { FactoryGirl.create(:recurrence) }

  it "#admin_link"

  it "#comment_link"

  describe "#email_link" do
    it "should generate the link" do
      helper.email_link([user], recurrence).should match(/\<a class="icon-envelope" href="mailto:john@doe.com?(.*)body=(.*)subject=(.*)" title="(.*)"\>\<\/a\>/)
    end
  end

  it "#format_date"

  it "#2x #google_link"

end

