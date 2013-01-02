require 'spec_helper'

describe UsersController do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) { controller.stub(current_user: user) } # request valid session

  describe "GET index" do
    def do_get
      get :index
    end

    it "should be successfull" do
      do_get
      expect(response).to be_success
    end

    it "finds all users" do
      User.should_receive(:find).with(:all).and_return([user])
      do_get
    end

    it "assigns an array of users" do
      do_get
      expect(assigns[:users]).to eq([user]) #or: be_instance_of(Array) #
    end

    it "renders the index template" do
      do_get
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    def do_get
      get :show, id: user
    end

    it "should be successfull" do
      do_get
      expect(response).to be_success
    end

    it "finds a single user" do
      User.should_receive(:find).with(user.id.to_s).and_return(user)
      do_get
    end

    it "assigns a single user" do
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders the show template" do
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe "POST create" do
    before { User.stub(:new).and_return(user) }

    def do_post
      post :create
    end

    it "creates a new user" do
      User.should_receive(:new).with("name" => "Joe").and_return(user)
      post :create, user: { "name" => "Joe" }
    end

    it "increments users by one" do
      expect{ do_post }.to change{ User.count }.by(1)
    end

    context "when the user saves successfully" do
      before { user.stub(:save).and_return(true) }

      it "sets a flash[:notice]" do
        do_post
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the user profil" do
        do_post
        expect(response).to redirect_to edit_user_path(user)
      end
    end

    context "when the user fails to save" do
      before { user.stub(:save).and_return(false) }

      it "assigns a user" do
        do_post
        expect(assigns[:user]).to eq(user)
      end

      it "renders the new template" do
        do_post
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    before { User.stub(:new).and_return(user) }

    def do_put
      put :update, id: user.id
    end

    it "finds an existing user" do
      User.should_receive(:find).with(user.id.to_s).and_return(User) # just working with to_s !?
      do_put
    end

    it "updates an existing user" do
      User.should_receive(:update_attributes).with("name" => "Joe").and_return(User)
      put :update, id: user, "name" => "Joe"
    end

    context "when the user updates successfully" do
      before { user.stub(:save).and_return(true) }

      it "sets a flash[:notice]" do
        do_put
        expect(flash[:notice]).not_to be(nil)
      end

      it "redirects to the user profil" do
        do_put
        expect(response).to redirect_to user_path(user)
      end
    end

    context "when the user fails to update" do
      before { user.stub(:save).and_return(false) }

      it "assigns a user" do
        do_put
        expect(assigns[:user]).to eq(user)
      end

      it "renders the edit template" do
        do_put
        expect(response).to render_template(:action => "edit")
      end
    end
  end

  describe 'DELETE destroy' do
    def do_delete
      delete :destroy, id: user
    end

    it "finds the user" do
      User.should_receive(:find).with(user.id.to_s).and_return(User) # just working with to_s !?
      do_delete
    end

    it "deletes the user" do
      expect{ do_delete }.to change(User, :count).by(-1)
    end

    it "sets a flash[:notice]" do
      do_delete
      expect(flash[:notice]).not_to be(nil)
    end

    it "redirects to users index" do
      do_delete
      expect{ response}.to redirect_to root_url
    end
  end

end

