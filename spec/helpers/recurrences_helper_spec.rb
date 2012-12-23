# encoding: UTF-8
require 'spec_helper'

describe RecurrencesHelper do
  let(:user) { FactoryGirl.create(:user) }
  let(:recurrence) { FactoryGirl.create(:recurrence) }

  before(:each) do
    helper.stub(current_user: user)
  end

  #let(:participation) { FactoryGirl.create(:participation, recurrence: recurrence, user: user) }

  #let(:participant) { create(:participant, user: event.user) }
  #let(:participation_event) { create(:event, participants: [participant]) }

  describe "#participation_link" do
    context "for not yet responded recurrence" do
      it "should render accept button" do
        helper.participation_link(recurrence, 'accept').should match("Zusagen")
      end

      it "should render refuse button" do
        helper.participation_link(recurrence, 'refuse').should match("Absagen")
      end
    end

    context "for initially accepted recurrence" do
      let(:participation) { FactoryGirl.create(:participation, recurrence: recurrence, user: user, status: true) }

      it "should render refuse button" do
        helper.participation_link(recurrence).should match("Absagen")
      end
    end

    context "for initially refused recurrence" do
      let(:participation) { FactoryGirl.create(:participation, recurrence: recurrence, user: user, status: nil) }

      it "should render accept button" do
        helper.participation_link(recurrence).should match("Zusagen")
      end
    end
  end

end

