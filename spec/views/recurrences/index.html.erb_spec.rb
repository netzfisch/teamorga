require 'spec_helper'

describe "recurrences/index" do

  before(:each) do
    assign(:recurrences, [
      mock_model(Recurrence, :scheduled_to => "2012-07-12").as_new_record.as_null_object,
      mock_model(Recurrence, :scheduled_to => "2012-12-18").as_new_record.as_null_object
    ])
    #view.stub(:logged_in?).and_return(true)
    render
  end

  it "should render successfully" do
    expect(rendered).to include("Zusagen", "Absagen", "Offen")
  end

  it "should have table header elements with participation status" do
    expect(rendered).to have_selector("table thead tr th", :text => "Zusagen")
  end

  it "should display both recurrences" do
    expect(rendered).to match /2012-07-12/
    expect(rendered).to match /2012-12-18/
  end

  it "should link to the different recurrences" do
    Recurrence.paginate(page: 1).each do |recurrence|
      expect(rendered).to have_tag("li a[href=#{recurrence_path(recurrence)}]", text: recurrence.scheduled_to)
    end
  end

  it "should have a paginate link"

  it "should have a NEW link" do
    expect(rendered).to have_selector 'a', :href => new_event_path, :content => 'New'
  end

end

