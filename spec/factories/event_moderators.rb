FactoryGirl.define do
  factory :event_moderator do
    user
    event

    factory :event_moderator_example do
      after(:create) do |event_moderator|
        event_moderator.user.add_role :event_moderator, event_moderator.event
      end
    end
  end
end
