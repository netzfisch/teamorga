require 'spec_helper'

describe Event do

  subject(:event) { FactoryGirl.create(:event) }

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

  it "is not valid without a place" do
    event.place = nil
    event.should_not be_valid
  end

  describe '#dates_between' do
    context 'finds recurrences dates of a event' do
      start_date = "2012-12-01"
      end_date = "2012-12-15"
      output_dates = ["2012-12-01", "2012-12-08", "2012-12-15"]

      it 'should call dates_between with two arguments' do
        event.should_receive(:dates_between).with(start_date, end_date).and_return(output_dates)
        event.dates_between(start_date, end_date).should eq(output_dates)
      end

      it 'should find and return the RIGHT recurrences dates' do
        Event.dates_between(start_date, end_date).should eq(output_dates)
      end
    end
  end

end

