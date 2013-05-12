require 'spec_helper'

describe "backoffice/groups/show" do
  before(:each) do
    @backoffice_group = assign(:backoffice_group, stub_model(Backoffice::Group,
      :name => "Name",
      :logo_url => "Logo Url",
      :public_information => "MyText",
      :private_information => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Logo Url/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
