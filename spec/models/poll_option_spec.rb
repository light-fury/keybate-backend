require 'rails_helper'

RSpec.describe PollOption, type: :model do
  subject { build(:poll_option) }

  it { should validate_presence_of(:description) }

  it { should belong_to(:poll).counter_cache(:options_count) }
end
