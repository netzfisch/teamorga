require 'spec_helper'
require 'will_paginate/array'

describe "recurrences/index" do
# see Mislav's gist at https://gist.github.com/mislav/587c1a6daa775f5c85fc and
# https://groups.google.com/forum/#!msg/will_paginate/i2LCboRZWfs/DpGHi5Msc74J
 
  let(:recurrences) { create_recurrences("2013-07-05", "2013-07-12", "2013-07-19") }
 
  def create_recurrences(*dates)
    dates.map { |date| FactoryGirl.create(:recurrence, scheduled_to: date) }
  end

# let(:recurrences) do [
#   FactoryGirl.create(:recurrence, scheduled_to: "2013-07-05"),
#   FactoryGirl.create(:recurrence, scheduled_to: "2013-07-12"),
#   FactoryGirl.create(:recurrence, scheduled_to: "2013-07-19")
#   ]
# end

  let(:group) { stub_model(Group, :name => "AlTSV", :private_information => "PrivateText" ) }

  before :each do
    assign(:recurrences, recurrences.paginate(page: 1, per_page: 2))
    assign(:groups, [group])
    render
  end

  it { should_not be_nil }
  it { should render_template("index") }

  it "shows column headers" do
    expect(rendered).to match /Zusagen/
    expect(rendered).to match /Absagen/
    expect(rendered).to match /Offen/
  end

  it "shows participation status" do
    expect(rendered).to have_selector("table thead tr th", text: "Zusagen")
  end 

  it "shows two recurrences" do
    expect(rendered).to have_selector("a", text: "07", count: 2)
  end

  it "renders recurrences links" do
    recurrences.paginate(page: 1, per_page: 2).each do |recurrence|
      expect(rendered).to have_link("#{recurrence.scheduled_to.strftime("%d.%m.")}", href: recurrence_path(recurrence))
    end
  end

  it "renders a EDIT link" do
    expect(rendered).to have_link("Manage", href: events_path)
  end

  it "renders a NEW link" do
    expect(rendered).to have_link("new", href: new_event_path)
  end

  it "renders a pagination bar" do
    expect(rendered).to have_selector("div.pagination")
  end

  context "shows group content" do
    it "renders private information" do
      expect(rendered).to have_selector("p#private_information")
    end

    it "renders a EDIT link" do
      expect(rendered).to have_link("Edit", href: edit_backoffice_group_path(group))
    end
  end
end
