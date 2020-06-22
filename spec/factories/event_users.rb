FactoryGirl.define do
  factory :event_user do
    user
    event

    factory :event_user_example do
      after(:create) do |event_user|
        event_user.user.add_role :event_attendee, event_user.event
      end
    end
  end
end
