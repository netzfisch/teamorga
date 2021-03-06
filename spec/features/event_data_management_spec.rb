require 'spec_helper'
   
feature "event data management" do
  given!(:group) { FactoryGirl.create(:group) }
  given!(:event) { FactoryGirl.create(:event, category: "Training") }
  given(:recurrence) { FactoryGirl.create(:recurrence, event: event) }

  before(:each) { login! FactoryGirl.create(:user) }

  scenario "edits a event with nested recurrence date" do
    visit recurrence_path(recurrence)
    click_link "Edit"

    expect(current_path).to eq edit_event_path(event)

    fill_in "Category", with: "Beachen"
    find(:xpath, '//*[@id="event_recurrences_attributes_0_scheduled_to_1i"]').select("2013")
    find(:xpath, '//*[@id="event_recurrences_attributes_0_scheduled_to_2i"]').select("October")
    find(:xpath, '//*[@id="event_recurrences_attributes_0_scheduled_to_3i"]').select("8")
    click_button "Update Event"

    expect(current_path).to eq event_path(event)
    expect(page).to have_content "Event was successfully updated."
    expect(page).to have_content "Beachen"
    expect(page).to have_content "08. Oct. 2013"
  end

  scenario "deletes a event" do
    visit events_path

    expect{
      click_link "Destroy"
    }.to change(Event, :count).by(-1)

    expect(current_path).to eq events_path
    expect(page).not_to have_content "Beachen"
  end
end  
