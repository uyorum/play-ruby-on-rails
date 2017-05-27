FactoryGirl.define do
  factory :micropost do
    association :user
    content "I just ate an orange!"
    created_at 10.minutes.ago
  end
end
