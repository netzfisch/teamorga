require 'spec_helper'
require 'will_paginate/array'

describe "recurrences/index" do

  let(:recurrences) do # { [10.times { FactoryGirl.create(:recurrence) }] }
      [ FactoryGirl.create(:recurrence, scheduled_to: "2013-07-05"),
      FactoryGirl.create(:recurrence, scheduled_to: "2013-07-12"),
      FactoryGirl.create(:recurrence, scheduled_to: "2013-07-19") ]
  end

  before :each do
    assign(:recurrences, recurrences)
#    view.stub(:will_paginate).with(page: "1").and_return(recurrences.paginate(per_page: 2))
    view.stub(:will_paginate).and_return(recurrences.paginate)
#    stub(:paginate).with(page: "1").and_return(recurrences.paginate(per_page: 2))
  
    render
  end
  it "renders a pagination bar", focus: true do
    dates = (1..5).map { mock_model(Recurrence) }

    #dates = assign ..
    #assign(:recurrences, [
    #       stub_model (:Recurrence, scheduled_to: "2013-07-05"),
    #       stub_model (:Recurrence, scheduled_to: "2013-07-12"),
    #       stub_model (:Recurrence, scheduled_to: "2013-07-19")
    #])
    Recurrence.stub_chain(:current, :paginate).with(page: "1").and_return(dates.paginate(page: 1, per_page: 2))
    view.stub(:will_paginate)

    render
    #get :index, :page => 2

    expect(rendered).to match /div.pagination/
  end
      
  it "test_should_get_index_with_data", focus: true do
    data = (1..5).map { mock_model(Recurrence)  }
    Recurrence(:paginate).with(:page => "2").and_return(data.paginate(:per_page => 4))

    get :index, :page => 2
    # this is what will_paginate should render by default:
    expect(rendered).to match /Next/ # 'div.pagination'
  end
  it "should have a pagination bar", focus: true do
    expect(rendered).to match /Next/ #have_selector('div.pagination') # match /Next/
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

end

