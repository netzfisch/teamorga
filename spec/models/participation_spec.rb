require 'spec_helper'

describe Participation do
  let(:participation) { FactoryGirl.create(:participation) }

  it "is valid with valid attributes" do
    expect(participation).to be_valid
  end

  it "is not valid without :recurrence_id" do
    participation.recurrence_id = nil
    expect(participation).not_to be_valid
  end

  it "is not valid without :user_id" do
    participation.user_id = nil
    expect(participation).not_to be_valid
  end

  it "has a default participation status of refused" do
    participation = Participation.new
    expect(participation.status).to be(false)
  end

  context '.accepted' do
    it "excludes refused participations" do
      2.times { FactoryGirl.create(:participation, status: false) }

      expect(Participation.count).to eq(2)
      expect(Participation.accepted).to be_empty
    end

    it "includes accepted participations" do
      3.times { FactoryGirl.create(:participation, status: true) }
      2.times { FactoryGirl.create(:participation, status: false) }

      expect(Participation.count).to eq(5)
      expect(Participation.accepted).to have_exactly(3).items
      expect(Participation.accepted.map(&:status).uniq).to eq([true])
    end
  end

  context '.refused scope' do
    it "excludes accepted participations" do
      2.times { FactoryGirl.create(:participation, status: true) }

      expect(Participation.count).to eq(2)
      expect(Participation.refused).to be_empty
    end

    it "includes refused participations" do
      3.times { FactoryGirl.create(:participation, status: true) }
      2.times { FactoryGirl.create(:participation, status: false) }

      expect(Participation.count).to eq(5)
      expect(Participation.refused).to have_exactly(2).items
      expect(Participation.refused.map(&:status).uniq).to eq([false])
    end
  end
end
