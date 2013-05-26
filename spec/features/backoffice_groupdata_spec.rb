require 'spec_helper'
   
feature "backoffice group data management" do
  given(:admin) { FactoryGirl.create(:user, :admin) }

  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password 
    click_button "Log in"
  end  

  before :each do
    user = FactoryGirl.create(:user)
    login!(user)
  end

  scenario "adds a group" do
    visit "/backoffice"
    click_link "Groupdata"
    current_path.should eq backoffice_groups_path 
  
    expect{
      click_link "New"
      fill_in "Name", with: "Training am"
      fill_in "Logo url", with: "http://gravatar.com/123456789"
      fill_in "Public information", with: "Volleyball workout takes place at ..."
      fill_in "Private information", with: "Private birthday meet up at ..."
      click_button "Create"
    }.to change(Group, :count).by(1) 

    current_path.should eq backoffice_group_path(Group.last)
    page.should have_content "Group was successfully created."
  end

  it "edits a group" do
    group = FactoryGirl.create(:group, name: "ATSV", public_information: "2. Herren")

    visit "/backoffice"
    click_link "Groupdata"
    click_link "Edit"
    fill_in "Name", with: "Altonaer TSV"
    fill_in "Public information", with: "1. Herren"
    click_button "Update Group"

    current_path.should eq backoffice_group_path(group)
    page.should have_content "Altonaer TSV"

    group.reload
    group.name.should eq "Altonaer TSV"
    group.public_information.should eq "1. Herren"
  end

  it "shows a group" do
    group = FactoryGirl.create(:group, name: "ATSV", public_information: "Training 2. Herren")

    visit "/backoffice"
    click_link "Groupdata"
    click_link "Show"

    current_path.should eq backoffice_group_path(group)
    page.should have_content "ATSV"
    page.should have_content "Training 2. Herren"
  end

  it "deletes a group" do
    group = FactoryGirl.create(:group, name: "ATSV", public_information: "Training 2. Herren")

    visit "/backoffice"
    click_link "Groupdata"

    expect{
      click_link "Destroy"
    }.to change(Group, :count).by(-1)

    current_path.should eq backoffice_groups_path
    page.should_not have_content "Training 2. Herren"
  end
end  
