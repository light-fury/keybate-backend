require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build(:message) }

  it { should validate_presence_of(:body) }

  it { should belong_to(:contact) }
  it { should belong_to(:user) }
end
