FactoryGirl.define do
  factory :room do
    name { FFaker::Lorem.word }
    event
    
    trait :invalid do
      name ''
    end
  end
end
