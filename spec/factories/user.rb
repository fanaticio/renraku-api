FactoryGirl.define do
  factory :user do
    email    { Forgery::Internet.email_address }
    login    { Forgery::Name::first_name }
    password { Forgery::Basic.password(at_least: 8) }
  end
end
