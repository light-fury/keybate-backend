class AttendeeSerializer < ActiveModel::Serializer
  attributes :id, :callable, :joined_at, :left_at, :requested_call_at,
             :hung_up_at, :links

  # embed :ids, include: true

  has_one :room
  has_one :user

  def links
    {
      questions: api_questions_path(attendee_id: object.id)
    }
  end
end
