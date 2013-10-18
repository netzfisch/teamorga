require 'spec_helper'

describe PagesController do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommentsController. Be sure to keep this updated too.
  def valid_session
    controller.stub(current_user: FactoryGirl.create(:user))
  end

  it "renders the 'default' layout" do
    get :imprint, {}, valid_session

    expect(response).to render_template("layouts/sidebar_default")
  end

  it "renders static 'imprint' template" do
    get :imprint, {}, valid_session

    expect(response).to render_template("pages/imprint")
  end
end
