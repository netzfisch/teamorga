require 'spec_helper'

describe CommentsController do

  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to the Comment model, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { body: "this is my comment" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommentsController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: FactoryGirl.create(:user))
    # alternatively { session[:user_id] = user.id } or {:user_id => user.id} 
  end

  let(:recurrence) { FactoryGirl.create(:recurrence) }
  let(:comment) { Comment.create! valid_attributes }

  it "renders the 'backoffice' layout" do
    get :index, {}, valid_session
    expect(response).to render_template("layouts/sidebar_backoffice")
  end

  describe "GET index" do
    it "returns http success" do
      get :index, {}, valid_session
      expect(response).to be_success
    end

    it "renders the 'index' template" do
      get :index, {}, valid_session
      expect(response).to render_template("index")
    end

    it "assigns all comments as @comments" do
      comment = Comment.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns :comments).to eq([comment])
    end
  end

# describe "GET show" do
#   it "returns http success" do
#     get :show, {id: comment}, valid_session
#     expect(response).to be_success
#   end
#
#   it "renders the 'show' template" do
#     get :show, {id: comment}, valid_session
#     expect(response).to render_template :show
#   end
#
#   it "assigns the requested comment as @comment" do
#     comment = Comment.create! valid_attributes
#     get :show, {:id => comment.to_param}, valid_session
#     assigns(:comment).should eq(comment)
#   end
# end
#
# describe "GET new" do
#   it "returns http success" do
#     get :new, {}, valid_session
#     expect(response).to be_success
#   end
#
#   it "renders the 'new' template" do
#     get :new, {}, valid_session
#     expect(response).to render_template :new
#   end
#
#   it "assigns a new comment as @comment" do
#     get :new, {}, valid_session
#     assigns(:comment).should be_a_new(Comment)
#   end
# end
#
# describe "GET edit" do
#   it "returns http success" do
#     get :edit, {id: comment.to_param}, valid_session
#     expect(response).to be_success
#   end
#
#   it "renders the 'edit' template" do
#     get :edit, {id: comment.to_param}, valid_session
#     expect(response).to render_template :edit
#   end
#
#   it "assigns the requested comment as @comment" do
#     comment = Comment.create! valid_attributes
#     get :edit, {id: comment.to_param}, valid_session
#     assigns(:comment).should eq(comment)
#   end
# end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:comment => valid_attributes, recurrence_id: recurrence.id}, valid_session
        }.to change(Comment, :count).by(1)
      end

#     it "assigns a newly created comment as @comment" do
#       post :create, {:comment => valid_attributes}, valid_session
#       assigns(:comment).should be_a(Comment)
#       assigns(:comment).should be_persisted
#     end
#
#     it "sets a flash notice about the successful created comment" do
#       post :create, {:comment => valid_attributes}, valid_session
#       expect(flash[:notice]).not_to be(nil)
#     end

      it "redirects to the created comment" do
        post :create, {:comment => valid_attributes, recurrence_id: recurrence.id}, valid_session
        expect(response).to redirect_to(recurrence_path(Recurrence.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:comment => { }, recurrence_id: recurrence.id}, valid_session
        assigns(:comment).should be_a_new(Comment)
      end

#     it "re-renders the 'new' template" do
#       # Trigger the behavior that occurs when invalid params are submitted
#       Comment.any_instance.stub(:save).and_return(false)
#       post :create, {:comment => { }, recurrence_id: recurrence.id}, valid_session
#       response.should render_template("new")
#     end
    end
  end

# describe "PUT update" do
#   context "with valid params" do
#     it "updates the requested comment" do
#       #comment = Comment.create! valid_attributes
#       # Assuming there are no other comments in the database, this
#       # specifies that the Comment created on the previous line
#       # receives the :update_attributes message with whatever params are
#       # submitted in the request.
#       Comment.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
#       put :update, {:id => comment.to_param, :comment => { "these" => "params" }}, valid_session
#     end
#
#     it "assigns the requested comment as @comment" do
#       #comment = Comment.create! valid_attributes
#       put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
#       assigns(:comment).should eq(comment)
#     end
#
#     it "sets a flash notice about the successful updated comment" do
#       #comment = Comment.create! valid_attributes
#       put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
#       expect(flash[:notice]).not_to be(nil)
#     end
#
#     it "redirects to the comments list" do
#       #comment = Comment.create! valid_attributes
#       put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
#       response.should redirect_to(comments_path)
#     end
#   end
#
#   context "with invalid params" do
#     it "assigns the comment as @comment" do
#       comment = Comment.create! valid_attributes
#       # Trigger the behavior that occurs when invalid params are submitted
#       Comment.any_instance.stub(:save).and_return(false)
#       put :update, {:id => comment.to_param, :comment => { }}, valid_session
#       assigns(:comment).should eq(comment)
#     end
#
#     it "re-renders the 'edit' template" do
#       comment = Comment.create! valid_attributes
#       # Trigger the behavior that occurs when invalid params are submitted
#       Comment.any_instance.stub(:save).and_return(false)
#       put :update, {:id => comment.to_param, :comment => { }}, valid_session
#       response.should render_template("edit")
#     end
#   end
# end

  describe "DELETE destroy" do
    before(:each) { request.env["HTTP_REFERER"] = "http://test.host/comments" }

    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete :destroy, {:id => comment.to_param}, valid_session
      }.to change(Comment, :count).by(-1)
    end

    it "sets a flash notice about the successful destroyed comment" do
      comment = Comment.create! valid_attributes
      delete :destroy, {:id => comment.to_param}, valid_session
      expect(flash[:notice]).not_to be(nil)
    end

    it "redirects back to referer" do
      comment = Comment.create! valid_attributes
      delete :destroy, {:id => comment.to_param}, valid_session
      response.should redirect_to(:back)
    end
  end
end
