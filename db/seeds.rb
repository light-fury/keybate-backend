user = User.create!(
  {first_name: "First", last_name: "de Last", email: "test@example.com", location: nil, position: nil, password: "qwerty1234", picture_url: "https://placeholdit.imgix.net/~text?txtsize=200&w=300&h=300&txttrack=0&txt=Fd", api_user_id: nil, facebook_profile_link: nil, linkedin_profile_link: nil, questions_count: 0, upvotes_count: 0, provider: "email", uid: "test@example.com"}
)
user_two = User.create!(
  {first_name: "Second", last_name: "de Last", email: "test2@example.com", location: nil, position: nil, password: "qwerty1234", picture_url: "https://placeholdit.imgix.net/~text?txtsize=200&w=300&h=300&txttrack=0&txt=Sd", api_user_id: nil, facebook_profile_link: nil, linkedin_profile_link: nil, questions_count: 0, upvotes_count: 0, provider: "email", uid: "test2@example.com"}
)
event = Event.create!(
  {name: "Final Test", code: "geht", plan: "pro", event_date_start: nil, event_date_end: nil, cover: nil, description: "Testing options now.", category: nil, location: nil, practical_information: nil, organizer_contact: nil, isLive: false, event_users_count: 2, contacts_count: 1, questions_count: 0}
)
EventAgenda.create!([
  {event_id: event.id, date: nil, time_start: nil, time_end: nil, title: "Test"},
  {event_id: event.id, date: nil, time_start: nil, time_end: nil, title: "Second Item"}
])
EventModerator.create!([
  {user_id: user.id, event_id: event.id}
])
EventSpeaker.create!([
  {event_id: event.id, name: "Tester", affiliation: nil, picture: nil, biography: nil, role: nil}
])
EventSponsor.create!([
  {event_id: event.id, name: "Testing", contact_email: nil, picture: nil, description: nil}
])
EventUser.create!([
  {user_id: user.id, event_id: event.id},
  {user_id: user_two.id, event_id: event.id}
])
room = Room.create!([
  {name: "test", event_id: event.id, color: nil, dp_background_color: nil, dp_text_color: nil, dp_display_kb_logo: true, dp_display_room_info: true, dp_display_multiple_questions: false, dp_display_attendee_info: false, auto_allow_questions: true, displayed_poll: nil}
])
contact = Contact.create!(
  {event_id: event.id, to_user_id: user.id, from_user_id: user_two.id, last_message_sent_at: "2017-08-11 07:19:21", blocked: false, two_way_contact: false, blocked_by_id: nil}
)
Message.create!([
  {body: "Get schwifty.", contact_id: contact.id, user_id: user_two.id, blocked: false}
])
Notification.create!([
  {title: "New message", description: "You have a new message from Second.", user_id: user.id, read: false},
  {title: "New message", description: "You have a new message from Second.", user_id: user.id, read: false}
])
user.add_role :event_moderator, event
user.add_role :event_attendee, event
user.add_role :room_attendee, room
user_two.add_role :event_attendee, event
user_two.add_role :room_attendee, room
user_two.add_role :contact, user

user_three = User.create!(
  {first_name: "Third", last_name: "de Last", email: "test3@example.com", location: nil, position: nil, password: "qwerty1234", picture_url: "https://placeholdit.imgix.net/~text?txtsize=200&w=300&h=300&txttrack=0&txt=Sd", api_user_id: nil, facebook_profile_link: nil, linkedin_profile_link: nil, questions_count: 0, upvotes_count: 0, provider: "email", uid: "test3@example.com"}
)

EventUser.create!(
  {user_id: user_three.id, event_id: event.id},
)

user_three.add_role :event_attendee, event
user_three.add_role :room_attendee, room
