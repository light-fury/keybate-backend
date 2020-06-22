require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { build(:contact) }

  it { should belong_to(:event) }
  it { should belong_to(:from_user) }
  it { should belong_to(:to_user) }
  it { should have_many(:messages) }
  it { should have_many(:notifications) }
end
