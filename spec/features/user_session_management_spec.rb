require 'spec_helper'

feature "User session management" do
  given(:user) { User.create(name: "jdoe", email: "john@doe.com", password: "secret") }

  def login!
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"
  end  

  scenario "Signing in with false credentials" do
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "wrong-password"
    click_button "Log in"
    
    expect(page).to have_text("Invalid email or password!")
  end

  scenario "Signing in with correct credentials" do
    login!

    expect(page).to have_text("Logged in!")
    expect(page).to have_selector("a", :text => "jdoe")
    expect(page).to have_selector("table thead th .vertical", :text => "Zusagen")
  end

  scenario "Signing out" do
    login!
    visit "/recurrences"
    click_link "Logout"

    expect(page).to have_text("You must be logged in to access this section!")
  end  
end  
