FactoryGirl.define do
  factory :user do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    password "foobar"
    password_confirmation "foobar"
    email { Faker::Internet.email }

    factory :admin_user do
      admin true
    end

    factory :non_admin_user do
      admin false
    end
  end
end
