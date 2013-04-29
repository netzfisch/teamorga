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

  scenario "adds groupdata" do
    visit "/backoffice"
    click_link "Groupdata"
    current_path.should eq backoffice_groups_path 
  
    expect{
      click_link "New"
      fill_in "Name", with: "Training"
      fill_in "Logo Url", with: "http://gravatar.com/123456789"
      fill_in "Public Information", with: "Volleyball workout takes place at ..."
      fill_in "Private Information", with: "Private birthday meet up at ..."
      click_button "Create"
    }.to change(Group, :count).by(1)

    current_path.should eq backoffice_groups_path
    page.should have_content "Group was successfully created."
  end

  it "edits an event" do
    article = FactoryGirl.create(:article,
                                  name: "2 Ruby frameworks",
                                  body: "Rails and Sinatra")

    click_link "Manage Articles"
    click_link "Edit"
    fill_in "Name", with: "A tale of two frameworks"
    fill_in "Body", with: "Rails and Sinatra are both very useful."
    click_button "Update Article"

    current_path.should eq admin_articles_path
    page.should have_content "A tale of two frameworks"

    article.reload
    article.name.should eq "A tale of two frameworks"
    article.body.should eq "Rails and Sinatra are both very useful."
  end

  it "shows an event" do
    article = FactoryGirl.create(:article,
                                  name: "2 testing frameworks",
                                  body: "RSpec and MiniTest")

    click_link "Manage Articles"
    click_link "Show"

    current_path.should eq admin_article_path(article)
    page.should have_content "2 testing frameworks"
    page.should have_content "RSpec and MiniTest"
  end

  it "deletes an event" do
    article = FactoryGirl.create(:article,
                                  name: "2 Ruby frameworks")

    click_link "Manage Articles"

    expect{
      click_link "Destroy"
    }.to change(Article, :count).by(-1)

    current_path.should eq admin_articles_path
    page.should_not have_content "2 Ruby frameworks"
  end
end  
