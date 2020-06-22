FactoryGirl.define do
  factory :poll_option do
    description { FFaker::Lorem.paragraph }
    poll
  end
end
