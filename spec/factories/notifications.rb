FactoryGirl.define do
  factory :notification do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.paragraph }
    user
  end
end
