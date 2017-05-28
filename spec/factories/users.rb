FactoryGirl.define do
  factory :user do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    password "password"
    password_confirmation "password"
    email { Faker::Internet.email }

    factory :admin_user do
      admin true
    end

    factory :non_admin_user do
      admin false
    end

    factory :activated_user do
      activated true
    end
  end
end
