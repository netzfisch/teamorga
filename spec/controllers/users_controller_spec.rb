require 'spec_helper'

describe UsersController do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to the User model, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :name => "Jim", :email => "jim@doe.com", :password => "secret", :birthday => "1999-10-08", :phone => "+49 40 123 4567" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: user)
  end

  let(:user) { User.create! valid_attributes }

  describe "GET index" do
    it "returns http success" do
      get :index, {}, valid_session
      expect(response).to be_success
    end

    it "renders the 'index' template" do
      get :index, {}, valid_session
      expect(response).to render_template("index")
    end

    it "renders the 'application' layout" do
      get :index, {}, valid_session
      expect(response).to render_template("layouts/application")
    end

    it "assigns all users as @users" do
      #user = User.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns :users).to eq([user])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {id: user}, valid_session
      expect(response).to be_success
    end

    it "renders the 'show' template" do
      get :show, {id: user}, valid_session
      expect(response).to render_template :show
    end

    it "assigns the requested user as @user" do
      #user = User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, {}, valid_session
      expect(response).to be_success
    end

    it "renders the 'new' template" do
      get :new, {}, valid_session
      expect(response).to render_template :new
    end

    it "assigns a new user as @user" do
      get :new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: user.to_param}, valid_session
      expect(response).to be_success
    end

    it "renders the 'edit' template" do
      get :edit, {id: user.to_param}, valid_session
      expect(response).to render_template :edit
    end

    it "assigns the requested user as @user" do
      #user = User.create! valid_attributes
      get :edit, {id: user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes} #free registration, no 'valid_session' needed!
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes} #free registration, no 'valid_session' needed!
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "sets a flash notice about the successful created user" do
        post :create, {:user => valid_attributes} #free registration, no 'valid_session' needed!
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the created user" do
        post :create, {:user => valid_attributes} #free registration, no 'valid_session' needed!
        expect(response).to redirect_to(edit_user_path(User.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { }} #, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { }} #, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates the requested user" do
        #user = User.create! valid_attributes
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => user.to_param, :user => { "these" => "params" }}, valid_session
      end

      it "assigns the requested user as @user" do
        #user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "sets a flash notice about the successful updated user" do
        #user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the updated user" do
        #user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(User.last)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        #user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { }}, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        #user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    context "as admin user" do
      it "destroys the requested user" do
        requested_user = User.create! valid_attributes
        admin = FactoryGirl.create(:user, :admin)
        expect {
          delete :destroy, {:id => requested_user}, {:user_id => admin.id} #valid_session
        }.to change(User, :count).by(-1)
      end

      it "sets a flash notice about the successful destroyed user" do
        requested_user = User.create! valid_attributes
        admin = FactoryGirl.create(:user, :admin)
        delete :destroy, {:id => requested_user}, {:user_id => admin.id} #valid_session
        expect(flash[:notice]).to match(/successfully deleted!/)
      end

      it "redirects to the root url" do
        requested_user = User.create! valid_attributes
        admin = FactoryGirl.create(:user, :admin)
        delete :destroy, {:id => requested_user}, {:user_id => admin.id} #valid_session
        response.should redirect_to(users_path)
      end
    end

    context "as ordinary user" do
      it "destroys himself as user" do
        user = User.create! valid_attributes
        expect {
          delete :destroy, {:id => user}, {:user_id => user.id} #valid_session
        }.to change(User, :count).by(-1)
      end

      it "sets a flash notice about the successful destroyed user" do
        user = User.create! valid_attributes
        delete :destroy, {:id =>  user}, {:user_id => user.id} #valid_session
        expect(flash[:notice]).to match(/deleted and signed out!/)
      end

      it "redirects to the root url" do
        user = User.create! valid_attributes
        delete :destroy, {:id =>  user}, {:user_id => user.id} #valid_session
        response.should redirect_to(root_url)
      end
    end
  end
end
