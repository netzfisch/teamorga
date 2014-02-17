require 'spec_helper'

describe Event do
  let(:event) { FactoryGirl.create(:event) }

  it { should respond_to(:category) }
  it { should respond_to(:base_date) }
  it { should respond_to(:base_time) }
  it { should respond_to(:end_date) }
  it { should respond_to(:place) }

  it "is valid with valid attributes" do
    event.should be_valid
  end

  it "is not valid without a category" do
    event.category = nil
    event.should_not be_valid
    event.should have(1).errors_on(:category)
    event.errors[:category].should include("can't be blank")
  end

  it "is not valid without a base_date" do
    event.base_date = nil
    event.should_not be_valid
  end

  it "is not valid without a end_date" do
    event.end_date = nil
    event.should_not be_valid
  end

  it "is not valid without a place" do
    event.place = nil
    event.should_not be_valid
  end

  it "is not valid with a readonly recurrences association" do
    FactoryGirl.create(:recurrence, event: event)

    expect(event.recurrences.first.readonly?).to eq(false)
  end

  describe "#default_scope" do
    it 'orders events descending by date' do
      event_next = FactoryGirl.create(:event, base_date: Date.yesterday)
      event.update_attributes(base_date: Date.today)

      expect(Event.first).to eq(event)
    end

    it 'orders events ascending by time' do
      event_next = FactoryGirl.create(:event, base_time: Time.now + 1.hour)
      event.update_attributes(base_time: Time.now)

      expect(Event.first).to eq(event)
    end
  end

  describe '#dates_between' do
    start_date = Date.today
    end_date = Date.today + 2.weeks
    output_dates = [Date.today, Date.today + 1.weeks, Date.today + 2.weeks]

    it 'should call dates_between with two arguments' do
      event.should_receive(:dates_between).with(start_date, end_date).and_return(output_dates)
      event.dates_between(start_date, end_date).should eq(output_dates)
    end

    context 'when the end_date ist after the start_date' do
      it 'should return multiple dates as recurrences of the event' do
        event.dates_between(start_date, end_date).should eq(output_dates)
      end
    end

    context 'when the end_date is before the start_date' do
      it 'should return a single date as recurrence of the event' do
        event.dates_between(Date.today, Date.today - 1.day).should eq([Date.today])
      end
    end
  end

  describe '#create_recurrences' do
    before(:each) do
      Date.stub(:current).and_return(Date.new 2014,2,18)
      event.update_attributes(base_date: Date.current, end_date: Date.current)
    end

    it 'calls #dates_between' do
      expect(event).to receive(:dates_between).with(Date.current, Date.current).and_return(["2014-02-18"])
      event.create_recurrences
    end

    it 'creates a valid recurrence' do
      event.create_recurrences
      expect(event.recurrences.first).to be_valid
    end

    it 'creates one recurrence with a valid date' do
      event.create_recurrences
      expect(event.recurrences.count).to eq(1)
      expect(event.recurrences.first.scheduled_to).to eq(Date.current)
    end

    it 'creates two recurrences with different dates' do
      event.update_attributes(base_date: Date.current, end_date: Date.current + 7.days)
      event.create_recurrences

      expect(event.recurrences.count).to eq(2)
      expect(event.recurrences.first.scheduled_to).to eq(Date.current)
      expect(event.recurrences.second.scheduled_to).to eq(Date.current + 7.days)
    end
  end
end
