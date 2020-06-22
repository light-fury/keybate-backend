json.users @users do |user|
  json.(user, :id, :email)
  json.activity({ questions_count: user.questions_count, upvotes_count: user.upvotes_count })
end
