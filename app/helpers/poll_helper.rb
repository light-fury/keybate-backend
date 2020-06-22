module PollHelper
  def answered_by_user(poll)
    poll.answers.find_by(user_id: current_api_v1_user.id) ? true : false
  end
end
