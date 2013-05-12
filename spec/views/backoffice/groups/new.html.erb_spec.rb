require 'spec_helper'

describe "backoffice/groups/new" do
  before(:each) do
    assign(:backoffice_group, stub_model(Backoffice::Group,
      :name => "MyString",
      :logo_url => "MyString",
      :public_information => "MyText",
      :private_information => "MyText"
    ).as_new_record)
  end

  it "renders new backoffice_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => backoffice_groups_path, :method => "post" do
      assert_select "input#backoffice_group_name", :name => "backoffice_group[name]"
      assert_select "input#backoffice_group_logo_url", :name => "backoffice_group[logo_url]"
      assert_select "textarea#backoffice_group_public_information", :name => "backoffice_group[public_information]"
      assert_select "textarea#backoffice_group_private_information", :name => "backoffice_group[private_information]"
    end
  end
end
