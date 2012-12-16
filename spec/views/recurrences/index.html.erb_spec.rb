require 'spec_helper'

describe "recurrences/index" do

  let(:event) { FactoryGirl.create(:event) }

  before(:each) do
    assign(:recurrences, [stub_model(Recurrence, :scheduled_to => Date.today), mock_model(Recurrence)])
    render
  end

  it "should render successfully" do
    view.stubs(recurrences: [recurrence], event: event )
    expect(rendered).to render_template(:count => 3)
  end

  it "should have table header elements with participation status" do
    expect(response).to have_selector("table thead tr th", :text => "Zusagen")
  end

  it "should show a link the recurrences" do
    PENDING
  end

end

