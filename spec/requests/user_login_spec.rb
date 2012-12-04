require 'spec_helper'

describe "home page" do

  it "after successful login show home page" do
    user = User.create!(:name => "jdoe", :email => "jdoe", :password => "secret")
    # why should I change to factory_girl:
    # user = FactoryGirl.create(:user, :name => "jdoe", :username => "jdoe", :password => "secret")
    visit login_path # alternatively take the direct path "/login"
    fill_in "Email", :with => "jdoe"
    fill_in "Password", :with => "secret"
    click_button "Log in"

    expect(page).to have_selector("table thead th .vertical a", :text => "jdoe")
  end

end

