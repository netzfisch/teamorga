FactoryGirl.define do

  factory :participation do
    association :recurrence
    association :user
  end

end

