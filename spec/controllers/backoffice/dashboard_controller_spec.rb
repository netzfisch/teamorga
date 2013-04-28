require 'spec_helper'
 
describe Backoffice::DashboardController do

  describe "GET 'index'" do
    #user = FactoryGirl.create(:user)
    #session[:user_id] = user.id

    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
