FactoryGirl.define do
  factory :organization do
    name { Forgery::Name.company_name }
    user
  end
end
