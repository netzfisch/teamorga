FactoryGirl.define do

  factory :event do
    category "Training"
    base_date Date.today
    base_time Time.now
    end_date Date.today
    place "Halle"
  end

  factory :participation do
    association :recurrence
    association :user
  end

  # recurrence factory without associated participations
  factory :recurrence do
    association :event
    sequence(:scheduled_to) { |n| Date.today.advance(weeks: n) }

    factory :accepted_recurrence do
      ignore { participations_count 5 }

      after(:create) do |recurrence, evaluator|
        FactoryGirl.create_list(:participation, evaluator.participations_count,
          recurrence: recurrence,
          status: true)
       end
     end

    # user_with_posts will create post data after the user has been created
    factory :refused_recurrence do
      # posts_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        participations_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |recurrence, evaluator|
        FactoryGirl.create_list(:participation, evaluator.participations_count, recurrence: recurrence, status: false)
      end
    end
  end

  factory :user do
    sequence(:name)  { |n| "John #{n}" }
    email { "#{name.downcase}@doe.com" }
    password "foobar"
    password_confirmation "foobar"
    phone "+49 150 123 45 67"
    #birthday { 41.years.ago }

    trait :admin do
      admin true
      name  { "admin-#{name}" }
      email { "admin-#{email}" }
    end
  end

end

