FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "john_no_#{n}@doe.com" }
    role "customer"
    password "password"
    password_confirmation "password"
  end
end
