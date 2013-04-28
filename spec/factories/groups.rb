# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name "MyString"
    logo_url "MyString"
    public_information "MyText"
    private_information "MyText"
  end
end
