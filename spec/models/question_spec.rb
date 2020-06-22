require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { build(:question) }

  it { validate_presence_of(:message) }

  it { should belong_to(:room) }
  it { should belong_to(:user).counter_cache(:questions_count) }
  it { should have_many(:upvotes) }
  it { should have_many(:notifications) }
end
