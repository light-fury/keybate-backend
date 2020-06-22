FactoryGirl.define do
  factory :user do
    first_name            { FFaker::Name.first_name }
    sequence(:last_name)  { |n| "#{FFaker::Name.last_name} #{n}" }
    email                 { FFaker::Internet.safe_email("#{first_name} #{last_name}") }
    password              { FFaker::Internet.password }
    password_confirmation { password }

    trait :invalid do
      email ''
    end
  end
end