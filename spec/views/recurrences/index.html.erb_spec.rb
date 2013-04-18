require 'spec_helper'
# require 'will_paginate/array'

describe "recurrences/index" do

  let(:recurrences) do # { [10.times { FactoryGirl.create(:recurrence) }] }
      [ FactoryGirl.create(:recurrence, scheduled_to: "2012-07-05"),
      FactoryGirl.create(:recurrence, scheduled_to: "2012-07-12"),
      FactoryGirl.create(:recurrence, scheduled_to: "2012-07-19") ]
  end

  before :each do
    assign(:recurrences, recurrences)
    # view.stub(:paginate).with(page: 1).and_return(recurrences.paginate(per_page: 2))
    view.stub(:will_paginate) #.and_return(:paginate)
    render
  end

  it { should_not be_nil }
  it { should render_template("index") }

  it "should include column headers" do
    expect(rendered).to match /Zusagen/
    expect(rendered).to match /Absagen/
    expect(rendered).to match /Offen/
  end

  it "should have table header selectors with participation status" do
    expect(rendered).to have_selector("table thead tr th", text: "Zusagen")
  end 

  it "should display three recurrences" do
    expect(rendered).to have_selector('a', text: "07", count: 3)
  end

  it "should link to each single recurrence" do
    recurrences.each do |recurrence|
      expect(rendered).to have_link("#{recurrence.scheduled_to.strftime("%d.%m.")}", href: recurrence_path(recurrence))
    end
  end

  it "should have a EDIT link" do
    expect(rendered).to have_link("Edit", href: events_path)
  end

  it "should have a NEW link" do
    expect(rendered).to have_link("New", href: new_event_path)
  end

  it "should have a pagination bar" do
    expect(rendered).to match /Next/ #have_selector('div.pagination') # match /Next/
  end

end

