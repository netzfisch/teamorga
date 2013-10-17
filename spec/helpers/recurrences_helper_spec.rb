require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the RecurrencesHelper. For example:
#
# describe RecurrencesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe RecurrencesHelper do
  let(:user) { FactoryGirl.create(:user) }
  let(:recurrence) { FactoryGirl.create(:recurrence) }

  before(:each) do
    helper.stub(current_user: user)
  end

  describe "#participation_link" do
    context "for not yet responded recurrence" do
      it "should render accept button" do
        helper.participation_link(recurrence, 'refuse').should_not match("doch noch")
        helper.participation_link(recurrence, 'accept').should match("Zusagen")
      end

      it "should render refuse button" do
        helper.participation_link(recurrence, 'refuse').should_not match("doch noch")
        helper.participation_link(recurrence, 'refuse').should match("Absagen")
      end
    end

    context "for initially accepted recurrence" do
      it "should render just refuse button" do
        FactoryGirl.create(:participation, recurrence: recurrence, user: user, status: true)
        helper.participation_link(recurrence).should match("doch noch Absagen")
      end
    end

    context "for initially refused recurrence" do
      it "should render just accept button" do
        FactoryGirl.create(:participation, recurrence: recurrence, user: user, status: false)
        helper.participation_link(recurrence).should match("doch noch Zusagen")
      end
    end
  end

  describe "#google_link (2x)" do
    pending
  end
end
