require 'rails_helper'

RSpec.describe EventAgenda, type: :model do
  subject { build(:event_agenda) }

  it { should belong_to(:event) }
end
