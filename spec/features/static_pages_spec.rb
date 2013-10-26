require "spec_helper"

feature "static pages" do
  given(:user) { FactoryGirl.create(:user) }

  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password 
    click_button "Log in"
  end  

  scenario "shows 'Imprint' page" do
    login!(user)
    visit "/pages/imprint"

    #within "h3" do
      expect(page).to have_content "Imprint"
    #end
  end
end
