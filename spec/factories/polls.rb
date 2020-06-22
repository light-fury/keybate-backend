FactoryGirl.define do
  factory :poll do
    title { FFaker::Lorem.phrase }
    room
    event

    trait :invalid do
      title ''
    end
  end
end
