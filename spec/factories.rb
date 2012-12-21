FactoryGirl.define do

  factory :event do
    category "Training"
    base_date Date.today
    base_time Time.now
    end_date Date.today
    place "Halle"
  end

  factory :recurrence do
    scheduled_to '2012-12-12'
    association :event
  end

  factory :participation do
    association :recurrence
    association :user
  end

  factory :user do
    sequence(:name)  { |n| "John #{n}" }
    sequence(:email) { |n| "john_#{n}@doe.com" }
    password "foobar"
    password_confirmation "foobar"
    phone "+49 150 123 45 67"

    factory :admin do
      admin true
    end
  end

  factory :single_user, class: User do
    id 1
    name "John"
    email "john@doe.com"
    password "foobar"
    password_confirmation "foobar"
    phone "+49 150 123 45 67"
  end

end

