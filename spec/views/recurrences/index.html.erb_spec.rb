require 'spec_helper'

describe "recurrences/index" do



  before(:each) do
    #assign(:recurrences, [10.times { FactoryGirl.generate(:recurrence) }])
    #assign(:recurrences, [10.times { FactoryGirl.create(:recurrence, scheduled_to: "2012-12-18") } ] )
    assign(:recurrences, [
      FactoryGirl.build(Recurrence, scheduled_to: "2012-07-05"),
      FactoryGirl.build(Recurrence, scheduled_to: "2012-07-12"),
      FactoryGirl.build(Recurrence, scheduled_to: "2012-12-18") ])
    view.stub(:will_paginate).and_return(page: 1)
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

  it "should display two recurrences" do
    expect(rendered).to match /12.07./
    expect(rendered).to match /18.12./
  end

  it "should link to each single recurrence" do
    [FactoryGirl.create(Recurrence), scheduled_to: "2012-12-24", id: 3].each do |recurrence|
      expect(rendered).to have_selector('a', href: recurrence_path(recurrence), content: "24.12.")
    end
  end

  it "should have a pagination bar" do
    expect(response.body).to match /Previous/
  end

  it "should have a NEW link" do
    expect(rendered).to have_selector("a", :href => new_event_path, :content => "New")
  end

end

