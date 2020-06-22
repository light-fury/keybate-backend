require 'rails_helper'

RSpec.describe EventSponsor, type: :model do
  subject { build(:event_sponsor) }

  it { should belong_to(:event) }
end
