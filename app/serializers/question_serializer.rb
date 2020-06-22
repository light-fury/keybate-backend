class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :body, :answered_at, :score, :hidden, :links,
             :pinned_by_moderator, :displayed

  # embed :ids

  has_one :attendee
  has_one :room

  def links
    {
      favorite_questions: api_favorite_questions_path(question_id: object.id)
    }
  end
end
