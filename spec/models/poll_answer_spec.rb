require 'rails_helper'

RSpec.describe PollAnswer, type: :model do
  subject { build(:poll_answer) }

  it { should validate_uniqueness_of(:poll).scoped_to(:user_id) }

  it { should belong_to(:poll).counter_cache(:answers_count) }
  it { should belong_to(:user) }
  it { should belong_to(:option) }
end
