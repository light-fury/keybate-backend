class ModeratorSerializer < ActiveModel::Serializer
  attributes :id

  # embed :ids, include: true

  has_one :room
  has_one :user
end
