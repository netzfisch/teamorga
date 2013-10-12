require 'spec_helper'
   
feature "recurrence data management" do
  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password 
    click_button "Log in"
  end  

  before(:each) { login! FactoryGirl.create(:user) }

  given(:event) { FactoryGirl.create(:event, category: "Training", remark: "be there") }
  given!(:recurrence) { FactoryGirl.create(:recurrence, event: event) }

  scenario "deletes a recurrence" do
    recurrence = FactoryGirl.create(:recurrence, event: event, scheduled_to: "2013-10-15")
    visit events_path

    expect{
      click_link "2013-10-15"
    }.to change(Recurrence, :count).by(-1)

    expect(current_path).to eq events_path
    expect(page).not_to have_content "2013-10-15"
  end
end  
