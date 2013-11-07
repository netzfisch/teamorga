require 'spec_helper'
   
feature "group data management" do
  given(:admin) { FactoryGirl.create(:user, :admin) }
  given!(:group) { FactoryGirl.create(:group, name: "ATSV", public_information: "Training 2. Herren") }

  before(:each) { login!(FactoryGirl.create(:user)) }

  it "shows a group" do
    visit "/backoffice"
    click_link "Groupdata"

    current_path.should eq group_path(group)
    page.should have_content "ATSV"
    page.should have_content "Training 2. Herren"
  end

  it "edits a group" do
    visit "/backoffice"
    click_link "Groupdata"
    click_link "Edit"
    fill_in "Name", with: "Altonaer TSV"
    fill_in "group_public_information", with: "1. Herren"
    click_button "Update Group"

    current_path.should eq group_path(group)
    page.should have_content "Altonaer TSV"

    group.reload
    group.name.should eq "Altonaer TSV"
    group.public_information.should eq "1. Herren"
  end
end  
