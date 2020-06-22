require 'rails_helper'

RSpec.describe QuestionUpvote, type: :model do
  subject { build(:question_upvote) }

  it { should belong_to(:user).counter_cache(:upvotes_count) }
  it { should belong_to(:question).counter_cache(:upvotes_count) }
end
