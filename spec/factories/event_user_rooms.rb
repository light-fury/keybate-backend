FactoryGirl.define do
  factory :event_user_room do
    event_user
    room

    factory :event_user_room_example do
      after(:create) do |event_user_room|
        event_user_room.event_user.user.add_role :room_attendee, event_user_room.room
      end
    end
  end
end
