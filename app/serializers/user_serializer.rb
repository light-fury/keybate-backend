class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :location, :position,
             :picture_url, :api_user_id, :facebook_profile_link,
             :linkedin_profile_link, :links, :deleted

  def links
    {
      attendees: api_attendees_path(user_id: object.id),
      moderators: api_moderators_path(user_id: object.id),
      favorites: api_favorites_path(user_id: object.id),
      favorite_questions: api_favorite_questions_path(user_id: object.id),
      qcm_polls: api_qcm_polls_path(user_id: object.id)
    }
  end
end
