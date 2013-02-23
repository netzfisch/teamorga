FactoryGirl.define do

  factory :user do
    sequence(:name)  { |n| "John #{n}" }
    email { "#{name.downcase}@doe.com" }
    password "foobar"
    password_confirmation "foobar"
    phone { "+49 #{rand(1000000000)}" } #validates_uniqueness_of phone, so can't do "+49 150 123 45 67"
    #birthday { 41.years.ago }

    trait :admin do
      admin true
    end
  end

end

