require 'spec_helper'

describe SessionsController do
  let(:valid_user) { FactoryGirl.create(:user, email: "joe@doe.com", password: "foobar",
                                        password_confirmation: "foobar") }

  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to the Comment model, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { email: valid_user.email, password: valid_user.password }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Backoffice::GroupsController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: valid_user)
  end

  it "renders the 'application' layout" do
    get :new, {}
    expect(response).to render_template("layouts/application")
  end

  describe "GET new" do
    it "returns http success" do
      get :new, {}
      expect(response).to be_success
    end
    
    it "renders the 'new' template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new session (signs the user in)" do
        post :create, valid_attributes
        expect(session[:user_id]).to eq(valid_user.id)
      end

      it "sets a flash notice about the successful created session" do
        post :create, valid_attributes
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the root url" do
        post :create, valid_attributes
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid params" do
      # Trigger the behavior that occurs when invalid params are submitted
      invalid_attributes = { email: "not@existing.user", password: "with-wrong-password" }

      it "re-renders the 'new' template" do
        post :create, invalid_attributes
        expect(response).to render_template("new")
      end
      
      it "sets a flash alert about the invalid email or password" do
       post :create, invalid_attributes
       expect(flash[:alert]).not_to be(nil)
     end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested session (signs the user out)" do
      delete :destroy, valid_session
      expect(flash[:user_id]).to eq(nil)
    end

    it "sets a flash notice about the successful destroyed session" do
      delete :destroy, valid_session
      expect(flash[:notice]).not_to be(nil)
    end

    it "redirects to the root url" do
      delete :destroy, valid_session
      response.should redirect_to(root_url)
    end
  end
end
