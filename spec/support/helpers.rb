module Helpers
  def login!(user)
    visit "/login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"
  end
end

RSpec.configure do |c|
  c.include Helpers
end
