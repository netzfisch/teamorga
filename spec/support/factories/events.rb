FactoryGirl.define do

  factory :event do
    category "Training"
    base_date Date.today
    base_time Time.now
    end_date Date.today
    place "Halle"
  end

end

