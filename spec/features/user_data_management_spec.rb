require 'spec_helper'

feature "management of user data" do
  given(:user)       { FactoryGirl.create(:user, admin: false) }
  given(:other_user) { FactoryGirl.create(:user, admin: false) }
  given(:admin)      { FactoryGirl.create(:user, :admin) }
  given!(:group)     { FactoryGirl.create(:group) }

  context "with ordinary user rights" do
    it "does NOT see a backoffice link" do
      login!(user)
      visit root_path

      expect(page).not_to have_link("Backoffice", href: backoffice_path )
    end

    it "can NOT manage other user data" do
      login!(user)
      visit user_path(other_user)

      expect(page).not_to have_link("Edit", href: edit_user_path(other_user) )
      expect(page).not_to have_link("Destroy", href: user_path(other_user) )
    end

    it "can manage his own user data" do
      login!(user)
      visit user_path(user)

      expect(page).to have_link("Edit", href: edit_user_path(user) )
      expect(page).to have_link("Destroy", href: user_path(user) )

      expect{ click_link('Destroy') }.to change(User, :count).by(-1)
    end
  end

  context "with administraion rights" do
    it "does see a backoffice link" do
      login!(admin)
      visit root_path

      expect(page).to have_link("Backoffice", href: backoffice_path )
    end

    it "can manage other user data" do
      login!(admin)
      visit user_path(other_user)

      expect(page).to have_content('Administrator:')
      expect(page).to have_link("Edit", href: edit_user_path(other_user) )
      expect(page).to have_link("Destroy", href: user_path(other_user) )

      expect{ click_link("Destroy") }.to change(User, :count).by(-1)
    end

    it "can make other user to 'admin'" do
      login!(admin)
      visit edit_user_path(other_user)

      expect(page).to have_content("Admin")
      find(:xpath, '//*[@id="user_admin"]').set(true) # check the admin-checkbox

      expect{ click_button("Update User") }.to change(User.where(:admin => true), :count).from(1).to(2)
    end
  end  
end
