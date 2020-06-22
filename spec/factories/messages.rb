FactoryGirl.define do
  factory :message do
    body { FFaker::Lorem.paragraph }
    contact
    
    trait :invalid do
      body ''
    end
  end
end
