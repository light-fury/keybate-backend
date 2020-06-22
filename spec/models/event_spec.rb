require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { build(:event) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_inclusion_of(:plan).in_array(['pro', 'premium']) }

  it { should have_many(:rooms) }
  it { should have_many(:event_users) }
  it { should have_many(:users).through(:event_users) }
  it { should have_many(:event_moderators) }
  it { should have_many(:moderators).through(:event_moderators).source(:user) }
  it { should have_many(:notifications) }
end
