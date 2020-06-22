require 'rails_helper'

RSpec.describe Poll, type: :model do
  subject { create(:poll) }

  it { should validate_presence_of(:title) }

  it { should belong_to(:room) }
  it { should have_many(:options) }
  it { should have_many(:answers) }
  it { should have_many(:notifications) }
end
