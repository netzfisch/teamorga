require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  context "should validate" do

    it { should respond_to(:name) }
    it { should respond_to(:slug) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:phone) }
    it { should respond_to(:birthday) }
    it { should respond_to(:shirt_number) }
    it { should respond_to(:admin) }

    it "is valid with valid attributes" do
      user.should be_valid
    end

    #TODO: validate uniqueness_of name/email/phone and differentiating ":on => create/update"
    it "is not valid without a name" do
      invalid_user = user.update_attributes(:name => nil)
      user.should_not be_valid
      user.should have(1).errors_on(:name)
      user.errors[:name].should include("can't be blank")
    end

    it "is not valid without an email" do
      invalid_user = FactoryGirl.build(:user, email: nil)
      invalid_user.should_not be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      user.should_not be_valid
    end

    it "is not valid without a password confirmation" do
      user.password_confirmation = "mismatch"
      user.should_not be_valid
    end

    it "is not valid without a phone number" do
      user.phone = nil
      user.should_not be_valid
    end
    #TODO: why are rspec-core one-liner not working: it { should validate_presence_of :phone }

    it "is not valid with a shirt number greater two digits" do
      user.shirt_number = 100
      user.should_not be_valid
    end

    it 'orders users alphabetical by the name' do
      user_last = FactoryGirl.create(:user, name: "Wilm")
      user.update_attributes(name: "John")

      expect(User.last).to eq(user_last)
    end
  end

  context ".admin flag" do
    it "excludes users without admin flag" do
      non_admin = user.update_attributes!(admin: false)
      user.admin.should_not be(non_admin)
    end

    it "includes users with admin flag" do
      user.toggle!(:admin)
      user.should be_admin
    end
  end

  context '.licence scope' do
    it "excludes users with no shirt number" do
      2.times { |i| FactoryGirl.create(:user) }

      expect(User.count).to eq(2)
      expect(User.licence).to be_empty
    end

    it "includes users with shirt number" do
      3.times { |i| FactoryGirl.create(:user, shirt_number: i) }
      2.times { |i| FactoryGirl.create(:user, shirt_number: nil) }

      expect(User.count).to eq(5)
      expect(User.licence).to have_exactly(3).items
    end
  end

  context "finds participation info for specific recurrence" do
    let(:user) { FactoryGirl.create(:user) }
    let(:recurrence) { FactoryGirl.create(:recurrence) }

    it "#responded?" do
      user.responded?(recurrence).should be(false)
      user.participations.create(recurrence: recurrence, user: user)
      user.responded?(recurrence).should be(true)
    end

    it "#responded_at" do
      participation = user.participations.create(recurrence: recurrence, user: user)
      user.responded_at(recurrence).should eq(participation)
    end
  end

  describe "#next_birthday", focus: true do
    before(:each) { Date.stub!(:current).and_return(Date.new 2013,12,30) }
    
    it "calculates a already passed birthday" do
      user.update_attributes(birthday: "1999-12-25")
      expect(user.next_birthday).to eq(Date.parse "2014-12-25")
    end

    it "calculates todays birthday" do
      user.update_attributes(birthday: "2000-12-30")
      expect(user.next_birthday).to eq(Date.parse "2013-12-30")
    end

    it "calculates a soon coming birthday" do
      user.update_attributes(birthday: "2001-01-05")
      expect(user.next_birthday).to eq(Date.parse "2014-01-05")
    end
  end

  describe "#upcoming_birthdadys", focus: true do
    before(:each) { Date.stub!(:current).and_return(Date.new 2013,06,15) }

    it "excludes birthdays passed more than 1 day" do
      user.update_attributes(birthday: "2000-06-14")
      expect(User.upcoming_birthdays).to eq([])
    end

    it "includes birthdays of today" do
      user.update_attributes(birthday: "2000-06-15")
      expect(User.upcoming_birthdays).to eq([user])
    end

    it "includes birthdays scheduled just 14 days ahead" do #, focus: true do
      user.update_attributes(birthday: "2000-06-29")
      user_earlier = FactoryGirl.create(:user, birthday: "2000-06-21")
      expect(User.upcoming_birthdays).to eq([user_earlier, user])
    end

    it "excludes birthdays scheduled more than 14 days ahead" do
      user.update_attributes(birthday: Date.current + 15.days)
      expect(User.upcoming_birthdays).to be_empty
    end

    it "orderes birthdays ascending by month/day" do
      user.update_attributes(birthday: "2000-06-10")
      user_later = FactoryGirl.create(:user, birthday: "1999-06-20")

      expect(User.upcoming_birthdays.last).to eq(user_later) #[user, user_later])
    end
  end
end
