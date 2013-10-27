require 'spec_helper'

describe Group do
  it "is not valid without a name" do
    invalid_group = Group.create(name: nil)
    invalid_group.should_not be_valid
    invalid_group.should have(1).errors_on(:name)
    invalid_group.errors[:name].should include("can't be blank")
  end
end
