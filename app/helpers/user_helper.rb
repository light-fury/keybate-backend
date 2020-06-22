module UserHelper
  # Could easily be replaced by checking a role instead.
  def check_connection(user)
    return nil if user.id == current_api_v1_user.id

    possible_contact = user.contacts.find_by('to_user_id = :user_id AND two_way_contact = true', user_id: current_api_v1_user.id)
    other_possible_contact = user.contacts.find_by('from_user_id = :user_id', user_id: current_api_v1_user.id)

    if possible_contact
      return possible_contact.id
    elsif other_possible_contact
      return other_possible_contact.id
    else
      return nil
    end
  end
end
