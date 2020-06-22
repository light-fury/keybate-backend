require 'spec_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  # it { should validate_presence_of(:email) }

  it { should have_many(:event_users) }
  it { should have_many(:events).through(:event_users) }
  it { should have_many(:notifications) }
  it { should have_many(:answers) }
  it { should have_many(:questions) }
  it { should have_many(:upvotes) }
  it { should have_many(:event_moderators) }
  it { should have_many(:moderatored_events).through(:event_moderators).source(:event) }
  it { should have_many(:messages) }
end
