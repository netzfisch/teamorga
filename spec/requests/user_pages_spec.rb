require 'spec_helper'

describe "home page" do

  it "show home page after successful login" do
    user = User.create!(:email => "jdoe", :password => "secret", :name => "jdoe")
    # change to factory_girl
    # user = FactoryGirl.create(:user, :username => "jdoe", :password => "secret", :name => "jdoe")
    visit "/login"
    fill_in "Email", :with => "jdoe"
    fill_in "Password", :with => "secret"
    click_button "Log in"

    expect(page).to have_selector("table thead th .vertical a", :text => "jdoe")
  end

end

