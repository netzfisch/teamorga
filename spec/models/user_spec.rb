require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:phone) }
  it { should respond_to(:birthday) }
  it { should respond_to(:shirt_number) }
  it { should respond_to(:admin) }

  it "is valid with valid attributes" do
    @user.should be_valid
  end

  it "is valid with admin attribute set to 'true'" do
    @user.toggle!(:admin)
    @user.should be_admin
  end

#TODO: validate uniqueness_of name/email/phone and differentiating ":on => create/update"
  it "is not valid without a name" do
    @user = User.update(1, :name => nil)
    @user.should_not be_valid
    @user.should have(1).errors_on(:name)
    @user.errors[:name].should include("can't be blank")
  end

  it "is not valid without an email" do
    @user.email = nil
    @user.should_not be_valid
  end

  it "is not valid without a password" do
    @user.password = nil
    @user.should_not be_valid
  end

  it "is not valid without a password confirmation" do
    @user.password_confirmation = "mismatch"
    @user.should_not be_valid
  end

  it "is not valid without a phone number" do
    @user.phone = nil
    @user.should_not be_valid
  end
#TODO: why are rspec-core one-liner not working: it { should validate_presence_of :phone }

  it "is not valid with a shirt number greater two digits" do
    @user.shirt_number = 100
    @user.should_not be_valid
  end
#TODO: why are rspec-core one-liner not working: it { should ensure_length_of(:shirt_number).is_maximum(2) }

end

