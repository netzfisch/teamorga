require 'spec_helper'

feature 'backoffice data management' do
  given(:admin) { FactoryGirl.create(:user, :admin) }

  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password 
    click_button "Log in"
  end  

  scenario 'allows backoffice access' do
    login!(admin)
    visit '/backoffice' 

    current_path.should eq backoffice_path
    within 'h3' do
      page.should have_content 'Backoffice'
    end
    page.should have_content 'Groupdata'
    page.should have_content 'Members'
  end

  scenario 'denies backoffice access' 
end
