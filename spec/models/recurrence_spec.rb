require 'spec_helper'

describe Recurrence do
  let(:recurrence) { FactoryGirl.create(:recurrence) }

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

  describe ".default_scope" do
    it 'orders recurrences ascending by date' do
      recurrence_next = FactoryGirl.create(:recurrence, scheduled_to: Date.tomorrow)
      recurrence.update_attributes(scheduled_to: Date.today)

      expect(Recurrence.first).to eq(recurrence)
    end

    it 'orders recurrences ascending by time' do
      recurrence_second = FactoryGirl.create(:recurrence,
        event: FactoryGirl.create(:event, base_time: Time.now),
        scheduled_to: Date.today)

      recurrence_first = FactoryGirl.create(:recurrence,
        event: FactoryGirl.create(:event, base_time: Time.now - 3.hours),
        scheduled_to: Date.today)

      expect(Recurrence.first).to eq(recurrence_first)
    end
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

    it 'orderes ascending by date' do
      recurrence_next = FactoryGirl.create(:recurrence, scheduled_to: Date.tomorrow)
      recurrence.update_attributes(scheduled_to: Date.today)

      expect(Recurrence.current.last).to eq(recurrence_next)
    end

    it 'orders ascending by time' do
      recurrence_second = FactoryGirl.create(:recurrence,
        event: FactoryGirl.create(:event, base_time: Time.now),
        scheduled_to: Date.today)

      recurrence_first = FactoryGirl.create(:recurrence,
        event: FactoryGirl.create(:event, base_time: Time.now - 3.hours),
        scheduled_to: Date.today)

      expect(Recurrence.current.first).to eq(recurrence_first)
    end
  end

  describe "#feedback(true/false/none)" do
    it "finds users accepted the recurrence" do
      2.times { FactoryGirl.create(:participation,
                  recurrence: recurrence,
                  user: FactoryGirl.create(:user),
                  status: true )}

      expect(recurrence.feedback(true)).to have_exactly(2).items
    end

    it "finds users refused the recurrence" do
      rr = FactoryGirl.create(:refused_recurrence, participations_count: 3)

      expect(rr.feedback(false)).to have_exactly(3).items
    end

    it "finds users not replyed at the recurrence" do
      recurrence = FactoryGirl.create(:refused_recurrence, participations_count: 3)
      FactoryGirl.create(:user, shirt_number: "13") # this is the no 'replyer'!

      expect(User.count).to eq(4)
      expect(recurrence.no_feedback).to have_exactly(1).item
    end
  end
end
