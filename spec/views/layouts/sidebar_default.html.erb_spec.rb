require "spec_helper"

describe "layouts/sidebar_default" do
  before do
    view.stub(:current_user).and_return(stub_model(User))
  end

  it "displays all the widgets" do
    assign(:layoutus, [
           stub_model(User, :name => "birthdays"),
           stub_model(Comment, :name => "comments")
    ])

    render #:template => "layouts/sidebar_default.html.erb"

    expect(rendered).to match /birthdays/
    expect(rendered).to match /comments/
  end
end
