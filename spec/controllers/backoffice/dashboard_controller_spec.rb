require 'spec_helper'
 
describe Backoffice::DashboardController do

  let(:user) { FactoryGirl.create(:user) }

  # This should return the minimal set of attributes required to create a valid
  # Group. As you add validations to Backoffice::Group, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :name => "John", :email => "john@doe.com" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Backoffice::DashboardController. Be sure to keep this updated too.
  def valid_session
    { :user_id => user.id } # alternatively controller.stub(current_user: user) or session[:user_id] = user.id
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index, {}, valid_session
      expect(response).to be_success
    end

    it "renders the index template" do
      get :index, {}, valid_session
      expect(response).to render_template("backoffice/dashboard/index")
    end
  end

end
