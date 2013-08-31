require 'spec_helper'

feature "User session management" do
  given(:user) { FactoryGirl.create(:user, name: "jdoe") }

  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"
  end  

  context "has NO account" do
    scenario "registers with complete data" do
      visit "/signup"
      fill_in "Name", with: "John"
      fill_in "Email", with: "john@doe.com"
      find(:xpath, '//*[@id="user_password"]').set("foobar")
      find(:xpath, '//*[@id="user_password_confirmation"]').set("foobar")

      expect{ click_button "Create User" }.to change(User, :count).by(1)

      expect(current_path).to eq edit_user_path("john") 
      expect(page).to have_content "User was successfully created / Signed up!"
    end

    scenario "registers with incomplete data" do
      visit "/signup"
      fill_in "Name", with: nil #leave name blank = incomplete data!
      fill_in "Email", with: "john@doe.com"
      find(:xpath, '//*[@id="user_password"]').set("foobar")
      find(:xpath, '//*[@id="user_password_confirmation"]').set("foobar")

      expect{ click_button "Create User" }.to change(User, :count).by(0)

      expect(current_path).to eq users_path 
      expect(page).to have_content "Name can't be blank"
    end

    scenario "registers with wrong password confirmation" do
      visit "/signup"
      fill_in "Name", with: "john"
      fill_in "Email", with: "john@doe.com"
      find(:xpath, '//*[@id="user_password"]').set("foobar")
      find(:xpath, '//*[@id="user_password_confirmation"]').set("barfoo") #wrong password confirmation!

      expect{ click_button "Create User" }.to change(User, :count).by(0)

      expect(current_path).to eq users_path 
      expect(page).to have_content "Password doesn't match confirmation"
    end
  end

  context "has an account" do
    scenario "signs in with false credentials" do
      visit "/login"
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "wrong-password"
      click_button "Log in"
      
      expect(page).to have_text("Invalid email or password!")
    end

    scenario "signs in with correct credentials" do
      login!(user)

      expect(page).to have_text("Logged in!")
      expect(page).to have_selector("a", :text => "jdoe")
      expect(page).to have_selector("table thead th .vertical", :text => "Zusagen")
    end

    scenario "signs out as authenticated user" do
      login!(user)
      visit "/recurrences"
      click_link "Logout"

      expect(page).to have_text("You must be logged in to access this section!")
    end  
  end
end  
