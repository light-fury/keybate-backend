require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { build(:room) }

  it { validate_presence_of(:name) }

  it { should belong_to(:event) }
  it { should have_many(:polls) }
  it { should have_many(:questions) }
  it { should have_many(:event_user_rooms) }
  it { should have_many(:event_users).through(:event_user_rooms) }
  it { should have_many(:users).through(:event_users) }
  it { should have_many(:notifications) }
end
