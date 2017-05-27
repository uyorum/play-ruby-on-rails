FactoryGirl.define do
  factory :micropost do
    association :user
    content { Faker::Lorem.sentence(5) }
    created_at { Faker::Time.between(Time.zone.now - 3.years, Time.zone.now) }
  end
end
