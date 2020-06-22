FactoryGirl.define do
  factory :poll_answer do
    poll
    user
    association :option, factory: :poll_option
  end
end
