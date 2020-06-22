require 'rails_helper'

RSpec.describe EventModerator, type: :model do
  subject { build(:event_moderator) }

  it { should belong_to(:user) }
  it { should belong_to(:event) }
end
