require 'spec_helper'

feature "User data management" do
  given(:user)        { FactoryGirl.create(:user, admin: false) }
  given(:other_user)  { FactoryGirl.create(:user, admin: false) }
  given(:admin)       { FactoryGirl.create(:user, :admin) }

  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password 
    click_button "Log in"
  end  

  scenario "ordinary user can not manage other user data" do
    login!(user)
    visit user_path(other_user)

    expect(page).not_to have_link("Edit", href: edit_user_path(other_user) )
    expect(page).not_to have_link("Destroy", href: user_path(other_user) )
  end

  scenario "ordinary user can manage his own user data" do
    login!(user)
    visit user_path(user)

    expect(page).to have_link("Edit", href: edit_user_path(user) )
    expect(page).to have_link("Destroy", href: user_path(user) )

    expect{ click_link('Destroy') }.to change(User, :count).by(-1)
  end

  scenario "administrator can manage other user data" do
    login!(admin)
    visit user_path(other_user)

    expect(page).to have_content('Administrator:')
    expect(page).to have_link("Edit", href: edit_user_path(other_user) )
    expect(page).to have_link("Destroy", href: user_path(other_user) )

    expect{ click_link("Destroy") }.to change(User, :count).by(-1)
  end

  scenario "administrator can make other user to 'admin'" do
    login!(admin)
    visit edit_user_path(other_user)

    expect(page).to have_content("Admin")
    find(:xpath, '//*[@id="user_admin"]').set(true) # check the admin-checkbox

    expect{ click_button("Update User") }.to change(User.where(:admin => true), :count).from(1).to(2)
  end
end  
