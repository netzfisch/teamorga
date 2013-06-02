FactoryGirl.define do

  factory :comment do
    association :recurrence
    association :user
    body "My comment to ..."
  end

end

