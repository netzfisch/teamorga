require 'spec_helper'

describe "backoffice/groups/show" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "Name",
      :logo_url => "Logo Url",
      :public_information => "PublicText",
      :private_information => "PrivateText"
    ))
  end

  it "renders attributes in <p>" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Logo Url/)
    rendered.should match(/PublicText/)
    rendered.should match(/PrivateText/)
  end
end
