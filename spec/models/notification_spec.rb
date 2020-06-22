require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { build(:notification) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should belong_to(:user) }
  it { should belong_to(:event) }
  it { should belong_to(:room) }
  it { should belong_to(:contact) }
  it { should belong_to(:poll) }
  it { should belong_to(:question) }

  it { is_expected.to callback(:broadcast_create).after(:create) }
end
