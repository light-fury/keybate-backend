require 'rails_helper'

RSpec.describe EventSpeaker, type: :model do
  subject { build(:event_speaker) }

  it { should belong_to(:event) }
end
