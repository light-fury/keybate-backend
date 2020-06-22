FactoryGirl.define do
  factory :event do
    name { FFaker::Lorem.word }
    plan { %w(pro premium).sample }

    trait :invalid do
      name ''
    end
  end
end
