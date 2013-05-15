require 'spec_helper'

describe "backoffice/groups/new" do
  before(:each) do
    assign(:group, stub_model(Group,
      :name => "Name",
      :logo_url => "Logo Url",
      :public_information => "PublicText",
      :private_information => "PrivateText"
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => backoffice_groups_path, :method => "post" do
      assert_select "input#group_name", :name => "group[name]"
      assert_select "input#group_logo_url", :name => "group[logo_url]"
      assert_select "textarea#group_public_information", :name => "group[public_information]"
      assert_select "textarea#group_private_information", :name => "group[private_information]"
    end
  end
end
