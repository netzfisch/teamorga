require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe GroupsController do
  # This should return the minimal set of attributes required to create a valid
  # Group. As you add validations to Backoffice::Group, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :name => "ATSV", :public_information => "workout on tuesday" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Backoffice::GroupsController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: FactoryGirl.create(:user))
  end

  describe "GET show" do
    it "assigns the requested group as @group" do
      group = Group.create! valid_attributes
      get :show, {:id => group.to_param}, valid_session
      assigns(:group).should eq(group)
    end
  end

  describe "GET edit" do
    it "assigns the requested group as @group" do
      group = Group.create! valid_attributes
      get :edit, {:id => group.to_param}, valid_session
      assigns(:group).should eq(group)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested group" do
        group = Group.create! valid_attributes
        # Assuming there are no other groups in the database, this
        # specifies that the Group created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Group.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => group.to_param, :group => { "these" => "params" }}, valid_session
      end

      it "assigns the requested group as @group" do
        group = Group.create! valid_attributes
        put :update, {:id => group.to_param, :group => valid_attributes}, valid_session
        assigns(:group).should eq(group)
      end

      it "redirects to the group" do
        group = Group.create! valid_attributes
        put :update, {:id => group.to_param, :group => valid_attributes}, valid_session
        response.should redirect_to(group_path(Group.last))
      end
    end

    describe "with invalid params" do
      it "assigns the group as @group" do
        group = Group.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Group.any_instance.stub(:save).and_return(false)
        put :update, {:id => group.to_param, :group => {  }}, valid_session
        assigns(:group).should eq(group)
      end

      it "re-renders the 'edit' template" do
        group = Group.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Group.any_instance.stub(:save).and_return(false)
        put :update, {:id => group.to_param, :group => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end
end