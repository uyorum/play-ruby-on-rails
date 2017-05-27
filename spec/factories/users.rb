FactoryGirl.define do
  factory :user do
    name "Example User"
    password "foobar"
    password_confirmation "foobar"
    sequence(:email) {|n| "user#{n}@example.com"}
  end
end
