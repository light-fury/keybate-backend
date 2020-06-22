require 'rails_helper'

RSpec.describe EventUser, type: :model do
  subject { build(:event_user) }

  it { belong_to(:user) }
  it { belong_to(:event) }
  it { should have_many(:event_user_rooms) }
  it { should have_many(:rooms).through(:event_user_rooms) }
end
