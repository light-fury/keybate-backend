require 'rails_helper'

RSpec.describe EventUserRoom, type: :model do
  subject { build(:attendee) }

  it { belong_to(:event_user) }
  it { belong_to(:room) }
end
