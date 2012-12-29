require 'spec_helper'

describe Recurrence do

  subject(:recurrence) { FactoryGirl.create(:recurrence) }

  it { should respond_to(:scheduled_to) }

  it "is valid with valid attributes" do
    recurrence.should be_valid
  end

  it "is not valid without scheduled_to" do
    recurrence.scheduled_to = nil
    recurrence.should_not be_valid
    recurrence.should have(1).errors_on(:scheduled_to)
    recurrence.errors[:scheduled_to].should include("can't be blank")
  end

  it 'orders recurrences ascending by date' do
    recurrence_next = FactoryGirl.create(:recurrence, scheduled_to: Date.tomorrow)
    recurrence.update_attributes(scheduled_to: Date.today)

    expect(Recurrence.first).to eq(recurrence)
  end

  describe '.current' do
    it 'excludes recurrences scheduled for yesterday' do
      recurrence.update_attributes(scheduled_to: Date.today - 1.second)
      expect(Recurrence.current).to be_empty
    end

    it 'includes recurrences scheduled for today' do
      recurrence.update_attributes(scheduled_to: Date.today)
      expect(Recurrence.current).to eq([recurrence])
    end

    it 'includes recurrences scheduled for tomorrow' do
      recurrence.update_attributes(scheduled_to: Date.tomorrow)
      expect(Recurrence.current).to eq([recurrence])
    end

    it 'includes recurrences ordered ascending by date' do
      recurrence_next = FactoryGirl.create(:recurrence, scheduled_to: Date.tomorrow)
      recurrence.update_attributes(scheduled_to: Date.today)

      expect(Recurrence.current.last).to eq(recurrence_next)
    end
  end

  describe ".accepted_for" do
    it "counts accepted participation for specific recurrence" do
      recurrence = FactoryGirl.create(:recurrence)
      user = FactoryGirl.create(:user)

      expect{ FactoryGirl.create(:participation, recurrence: recurrence, user: user, status: true) }.to change(recurrence.accepted_for(recurrence)).by(1)
    end
  end

end

