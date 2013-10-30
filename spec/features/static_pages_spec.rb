require "spec_helper"

feature "static pages" do
  given(:user) { FactoryGirl.create(:user) }
  given!(:group) { FactoryGirl.create(:group) }

  scenario "shows 'Imprint' page" do
    login!(user)
    visit "/pages/imprint"

    #within "h3" do
      expect(page).to have_content "Imprint"
    #end
  end
end
