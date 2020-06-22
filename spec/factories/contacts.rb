FactoryGirl.define do
  factory :contact do
    event
    association :from_user, factory: :user
    association :to_user, factory: :user

    last_message_sent_at { DateTime.current }

    factory :contact_example do
      after(:create) do |contact|
        contact.from_user.add_role :contact, contact.to_user
      end
    end
  end
end
