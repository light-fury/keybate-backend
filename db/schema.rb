# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181116084550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "answered_polls", force: :cascade do |t|
    t.string   "option_letter"
    t.string   "answer_text"
    t.string   "room_name"
    t.integer  "qcm_poll_id"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "attendees", force: :cascade do |t|
    t.datetime "joined_at"
    t.datetime "left_at"
    t.integer  "room_id"
    t.datetime "requested_call_at"
    t.datetime "hung_up_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "callable",          default: false
    t.integer  "user_id"
  end

  create_table "contacts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "event_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.uuid     "to_user_id"
    t.uuid     "from_user_id"
    t.datetime "last_message_sent_at"
    t.boolean  "blocked",              default: false
    t.boolean  "two_way_contact",      default: false
    t.uuid     "blocked_by_id"
    t.index ["event_id"], name: "index_contacts_on_event_id", using: :btree
    t.index ["from_user_id"], name: "index_contacts_on_from_user_id", using: :btree
    t.index ["to_user_id"], name: "index_contacts_on_to_user_id", using: :btree
  end

  create_table "event_agendas", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "event_id"
    t.date     "date"
    t.time     "time_start"
    t.time     "time_end"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_agendas_on_event_id", using: :btree
  end

  create_table "event_moderators", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_moderators_on_event_id", using: :btree
    t.index ["user_id"], name: "index_event_moderators_on_user_id", using: :btree
  end

  create_table "event_speakers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "event_id"
    t.string   "name"
    t.text     "affiliation"
    t.string   "picture"
    t.text     "biography"
    t.string   "role"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_event_speakers_on_event_id", using: :btree
  end

  create_table "event_sponsors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "event_id"
    t.string   "name"
    t.string   "contact_email"
    t.string   "picture"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["event_id"], name: "index_event_sponsors_on_event_id", using: :btree
  end

  create_table "event_user_rooms", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "event_user_id"
    t.uuid     "room_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["event_user_id"], name: "index_event_user_rooms_on_event_user_id", using: :btree
    t.index ["room_id"], name: "index_event_user_rooms_on_room_id", using: :btree
  end

  create_table "event_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_users_on_event_id", using: :btree
    t.index ["user_id"], name: "index_event_users_on_user_id", using: :btree
  end

  create_table "events", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "code"
    t.string   "plan",                  default: "pro"
    t.datetime "event_date_start"
    t.datetime "event_date_end"
    t.string   "cover"
    t.text     "description"
    t.string   "category"
    t.string   "location"
    t.text     "practical_information"
    t.text     "organizer_contact"
    t.boolean  "isLive",                default: false
    t.integer  "event_users_count",     default: 0
    t.integer  "contacts_count",        default: 0
    t.integer  "questions_count",       default: 0
    t.time     "event_time_start"
    t.time     "event_time_end"
    t.index ["code"], name: "index_events_on_code", unique: true, using: :btree
  end

  create_table "favorite_questions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "room_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.boolean  "met_in_room",  default: false
    t.integer  "room_id"
    t.string   "room_name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "messages", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "body"
    t.uuid     "contact_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.uuid     "user_id"
    t.boolean  "blocked",    default: false
    t.boolean  "read",       default: false
    t.index ["contact_id"], name: "index_messages_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "moderators", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.uuid     "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "read",        default: false
    t.uuid     "event_id"
    t.uuid     "room_id"
    t.uuid     "poll_id"
    t.uuid     "question_id"
    t.uuid     "contact_id"
    t.uuid     "message_id"
    t.json     "data"
    t.index ["contact_id"], name: "index_notifications_on_contact_id", using: :btree
    t.index ["event_id"], name: "index_notifications_on_event_id", using: :btree
    t.index ["message_id"], name: "index_notifications_on_message_id", using: :btree
    t.index ["poll_id"], name: "index_notifications_on_poll_id", using: :btree
    t.index ["question_id"], name: "index_notifications_on_question_id", using: :btree
    t.index ["room_id"], name: "index_notifications_on_room_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "old_questions", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "attendee_id"
    t.text     "body"
    t.datetime "answered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",               default: 0
    t.boolean  "hidden",              default: false
    t.boolean  "pinned_by_moderator", default: false
    t.boolean  "displayed",           default: false
  end

  create_table "old_rooms", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room_name"
    t.integer  "moderator_id"
    t.boolean  "display_panel_display_new",            default: true
    t.boolean  "display_panel_display_poll",           default: false
    t.boolean  "display_panel_display_poll_results",   default: true
    t.integer  "display_panel_current_poll"
    t.boolean  "display_panel_display_poll_bar_chart", default: false
    t.boolean  "display_panel_display_poll_pie_chart", default: false
  end

  create_table "poll_answers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "poll_id"
    t.uuid     "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "option_id"
    t.index ["option_id"], name: "index_poll_answers_on_option_id", using: :btree
    t.index ["poll_id"], name: "index_poll_answers_on_poll_id", using: :btree
    t.index ["user_id"], name: "index_poll_answers_on_user_id", using: :btree
  end

  create_table "poll_options", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "description"
    t.uuid     "poll_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["poll_id"], name: "index_poll_options_on_poll_id", using: :btree
  end

  create_table "polls", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "title"
    t.uuid     "room_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "published",       default: false
    t.boolean  "open",            default: false
    t.boolean  "display_results", default: false
    t.integer  "options_count",   default: 0
    t.integer  "answers_count",   default: 0
    t.uuid     "event_id"
    t.integer  "list_order"
    t.index ["event_id"], name: "index_polls_on_event_id", using: :btree
    t.index ["room_id"], name: "index_polls_on_room_id", using: :btree
  end

  create_table "qcm_polls", force: :cascade do |t|
    t.string   "question"
    t.string   "option_a"
    t.integer  "option_a_score", default: 0
    t.string   "option_b"
    t.integer  "option_b_score", default: 0
    t.string   "option_c"
    t.integer  "option_c_score", default: 0
    t.string   "option_d"
    t.integer  "option_d_score", default: 0
    t.integer  "moderator_id"
    t.integer  "room_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "sent_out",       default: false
    t.integer  "total_answers",  default: 0
  end

  create_table "question_upvotes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_question_upvotes_on_question_id", using: :btree
    t.index ["user_id"], name: "index_question_upvotes_on_user_id", using: :btree
  end

  create_table "questions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "message"
    t.uuid     "room_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.uuid     "user_id"
    t.integer  "upvotes_count",  default: 0
    t.boolean  "displayed",      default: false
    t.uuid     "event_id"
    t.boolean  "hidden",         default: false
    t.boolean  "pinned_to_top",  default: false
    t.boolean  "sent_to_bottom", default: false
    t.boolean  "deleted",        default: false
    t.boolean  "allowed",        default: false
    t.datetime "time_displayed"
    t.datetime "time_pinned"
    t.boolean  "callable",       default: false
    t.index ["event_id"], name: "index_questions_on_event_id", using: :btree
    t.index ["room_id"], name: "index_questions_on_room_id", using: :btree
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.uuid     "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "rooms", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.uuid     "event_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "color"
    t.string   "dp_background_color"
    t.string   "dp_text_color"
    t.boolean  "dp_display_kb_logo",            default: true
    t.boolean  "dp_display_room_info",          default: true
    t.boolean  "dp_display_multiple_questions", default: false
    t.boolean  "dp_display_attendee_info",      default: false
    t.boolean  "auto_allow_questions",          default: true
    t.string   "displayed_poll"
    t.boolean  "allow_microphone_requests",     default: true
    t.string   "question_under_call"
    t.index ["event_id"], name: "index_rooms_on_event_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "location"
    t.string   "position"
    t.string   "picture_url"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "api_user_id"
    t.string   "facebook_profile_link"
    t.string   "linkedin_profile_link"
    t.integer  "questions_count",        default: 0
    t.integer  "upvotes_count",          default: 0
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.json     "tokens"
    t.text     "description"
    t.boolean  "deleted",                default: false
    t.index ["api_user_id"], name: "index_users_on_api_user_id", unique: true, using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.uuid    "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "contacts", "events"
  add_foreign_key "contacts", "users", column: "blocked_by_id"
  add_foreign_key "contacts", "users", column: "from_user_id"
  add_foreign_key "contacts", "users", column: "to_user_id"
  add_foreign_key "event_agendas", "events"
  add_foreign_key "event_moderators", "events"
  add_foreign_key "event_moderators", "users"
  add_foreign_key "event_speakers", "events"
  add_foreign_key "event_sponsors", "events"
  add_foreign_key "event_user_rooms", "event_users"
  add_foreign_key "event_user_rooms", "rooms"
  add_foreign_key "event_users", "events"
  add_foreign_key "event_users", "users"
  add_foreign_key "messages", "contacts"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "contacts"
  add_foreign_key "notifications", "events"
  add_foreign_key "notifications", "messages"
  add_foreign_key "notifications", "polls"
  add_foreign_key "notifications", "questions"
  add_foreign_key "notifications", "rooms"
  add_foreign_key "notifications", "users"
  add_foreign_key "poll_answers", "poll_options", column: "option_id"
  add_foreign_key "poll_answers", "polls"
  add_foreign_key "poll_answers", "users"
  add_foreign_key "poll_options", "polls"
  add_foreign_key "polls", "events"
  add_foreign_key "polls", "rooms"
  add_foreign_key "question_upvotes", "questions"
  add_foreign_key "question_upvotes", "users"
  add_foreign_key "questions", "events"
  add_foreign_key "questions", "rooms"
  add_foreign_key "questions", "users"
  add_foreign_key "rooms", "events"
end
