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
# TODO: shorter one-liner (http://rubydoc.info/gems/rspec-expectations/frames) not working!?
# it { should validate_presence_of :category }

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
end
