require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  context "should validate" do
    #subject { @user }

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

    #TODO: validate uniqueness_of name/email/phone and differentiating ":on => create/update"
    it "is not valid without a name" do
      @user = User.update(1, :name => nil)
      @user.should_not be_valid
      @user.should have(1).errors_on(:name)
      @user.errors[:name].should include("can't be blank")
    end

    it "is not valid without an email" do
      invalid_user = FactoryGirl.build(:user, email: nil)
      invalid_user.should_not be_valid
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

    it 'orders users alphabetical by the name' do
      user_last = FactoryGirl.create(:user, name: "Wilm")
      @user.update_attributes(name: "John")

      expect(User.last).to eq(user_last)
    end
  end

  context ".admin" do
    it "excludes users without admin flag" do
      non_admin = @user.update_attributes!(admin: false)
      @user.admin.should_not be(non_admin)
    end

    it "includes users with admin flag" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  context "finder" do
    let(:user) { FactoryGirl.create(:user) }
    let(:recurrence) { FactoryGirl.create(:recurrence) }

    it "#responded?" do
      user.responded?(recurrence).should be(false)
      user.participations.create(recurrence: recurrence, user: user)
      user.responded?(recurrence).should be(true)
    end
  end

end

