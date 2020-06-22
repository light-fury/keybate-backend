class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :met_in_room, :room_id, :room_name, :following_id, :created_at

  # embed :ids
  has_one :user
end
