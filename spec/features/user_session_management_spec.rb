require 'spec_helper'

feature "User session management" do
  given(:user) { FactoryGirl.create(:user, name: "jdoe") }

  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"
  end  

  scenario "sign in with false credentials" do
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "wrong-password"
    click_button "Log in"
    
    expect(page).to have_text("Invalid email or password!")
  end

  scenario "sign in with correct credentials" do
    login!(user)

    expect(page).to have_text("Logged in!")
    expect(page).to have_selector("a", :text => "jdoe")
    expect(page).to have_selector("table thead th .vertical", :text => "Zusagen")
  end

  scenario "sign out as authenticated user" do
    login!(user)
    visit "/recurrences"
    click_link "Logout"

    expect(page).to have_text("You must be logged in to access this section!")
  end  
end  
