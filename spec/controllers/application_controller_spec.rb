require "spec_helper"

describe ApplicationController do
  def valid_session
    controller.stub(current_user: user)
  end

  let(:user) { FactoryGirl.create(:user) }

  describe "handling of current_user" do
    controller do
      def index
        render :nothing => true
      end
    end

    context "if NOT logged in" do
      it "assigns nothing to @current_user" do
        get :index
        expect(assigns :current_user).to be_nil
      end
    end

    context "if logged in" do
      it "assigns the current_user as @current_user" do
        get :index, valid_session
        expect(assigns :current_user).to eq user
        #expect(session[:user_id]).to eq user.id
      end
    end
  end

  describe "handling of authentication" do
    controller do
      def index
        render :nothing => true
      end
    end

    context "if NOT logged in" do
      it "redirects to the new_session_path" do
        get :index
        expect(response).to redirect_to(new_session_path)
      end

      it "sets a flash error about unsuccessfull authentication" do
        get :index
        expect(flash[:error]).not_to be_nil
      end
    end

    context "if logged in" do
      it "ensures user session exists" do
        get :index, valid_session
        expect(assigns :require_login).to be_nil
      end
    end
  end
end
