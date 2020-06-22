class FavoriteQuestionSerializer < ActiveModel::Serializer
  attributes :id, :room_name

  has_one :user
  has_one :question
end
