require "spec_helper"

feature "backoffice access management" do
  given(:user) { FactoryGirl.create(:user) }
  given(:admin) { FactoryGirl.create(:user, :admin) }
  given!(:group) { FactoryGirl.create(:group) }

  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password 
    click_button "Log in"
  end  

  scenario "denies backoffice access" do 
    login!(user)

    expect(page).not_to have_link "Backoffice"
    expect(page).to have_link "Logout"
# after CanCan integration - better write:
    # login!(user)
    # expect(page).not_to have_link "Backoffice"
    #
    # visit "/backoffice"
    # expect(current_path).to eq root_url #access denied!
    # expect(page).to have_content "Your are not qualified for the backoffice!" 
  end

  scenario "allows backoffice access" do
    login!(admin)
    expect(page).to have_link "Backoffice"

    click_link "Backoffice"

    expect(current_path).to eq backoffice_path
    within "h3" do
      expect(page).to have_content "Backoffice"
    end
    expect(page).to have_content "Groupdata"
    expect(page).to have_content "Users"
    expect(page).to have_content "Events"
    expect(page).to have_content "Comments"
  end
end
