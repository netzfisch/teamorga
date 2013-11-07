require 'spec_helper'
   
feature "recurrence data management" do
  given!(:group) { FactoryGirl.create(:group) }
  given(:event) { FactoryGirl.create(:event, category: "Training", remark: "be there") }
  given!(:recurrence) { FactoryGirl.create(:recurrence, event: event) }

  before(:each) { login! FactoryGirl.create(:user) }

  scenario "deletes a recurrence" do
    recurrence = FactoryGirl.create(:recurrence, event: event, scheduled_to: "2013-10-15")
    visit event_path(recurrence.event)

    expect{
      click_link "Delete"
    }.to change(Recurrence, :count).by(-1)

    expect(current_path).to eq events_path
    expect(page).not_to have_content "2013-10-15"
  end
end  
