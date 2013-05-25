require 'spec_helper'

describe "backoffice/groups/index" do
  before(:each) do
    assign(:groups, [
      stub_model(Group,
        :name => "Name",
        :logo_url => "Logo Url",
        :public_information => "PublicText",
        :private_information => "PrivateText"
      ),
      stub_model(Group,
        :name => "Name",
        :logo_url => "Logo Url",
        :public_information => "PublicText",
        :private_information => "PrivateText"
      )
    ])
  end

  it "renders a list of backoffice/groups" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Logo Url".to_s, :count => 2
    assert_select "tr>td", :text => "PublicText".to_s, :count => 2
    assert_select "tr>td", :text => "PrivateText".to_s, :count => 2
  end
end
