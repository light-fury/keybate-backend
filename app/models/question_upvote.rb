class QuestionUpvote < ApplicationRecord
  belongs_to :user, counter_cache: :upvotes_count
  belongs_to :question, counter_cache: :upvotes_count

  def self.policy_class
    UpvotePolicy
  end
end
