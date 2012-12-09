FactoryGirl.define do

  factory :event do
    category "Training"
    base_date "2012-12-01 18:25:25"
    base_time "18:25:25"
    end_date "2012-12-22 18:25:25"
    place "Halle"
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

