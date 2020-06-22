FactoryGirl.define do
  factory :question do
    message { FFaker::Lorem.paragraph }
    event
    room
    user

    trait :invalid do
      message ''
    end
  end
end
